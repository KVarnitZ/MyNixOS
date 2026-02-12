#!/usr/bin/env python3
import requests
import re
import json
import sys
from datetime import datetime

# Čerğa
TARGET_QUEUE = "GPV6.2"
URL = "https://www.dtek-dnem.com.ua/ua/shutdowns"

# Debug
DEBUG = "--debug" in sys.argv

def extract_current_schedule(html_text, queue_id):
    """
    Vytjağuje AKTUALJNYJ ğrafik na sjoğodni (verxnja tablycja).
    Na sajti je dva typy danyx:
    1. Aktualjnyj ğrafik (verxnja tablycja) - ključ "current" abo "today"
    2. Proğnoznyj ğrafik na tyždenj (nyžnja tablycja) - okremi ključi po dnjax
    """
    
    # Šukajemo JSON-ob'jekt z danymy
    # Varianty nazv zminnyx: scheduleData, currentSchedule, todaySchedule toŝo
    json_patterns = [
        r'var\s+currentSchedule\s*=\s*(\{.+?\});',
        r'var\s+todaySchedule\s*=\s*(\{.+?\});',
        r'var\s+actualSchedule\s*=\s*(\{.+?\});',
        r'(?:var|let|const)\s+\w*[Ss]chedule\w*\s*=\s*(\{.+?\});',
    ]
    
    for pattern in json_patterns:
        matches = re.finditer(pattern, html_text, re.DOTALL)
        for match in matches:
            try:
                json_str = match.group(1)
                data = json.loads(json_str)
                
                # Perevirjajemo čy je naša čerğa v cjomu ob'jekti
                if queue_id in data:
                    queue_data = data[queue_id]
                    
                    # Perevirjajemo, čy ce NE proğnozni dani (ne mistytj "maybe", "mfirst", "msecond")
                    # Aktualjni dani mistjatj "yes" i "no" abo prosto bulevi značennja
                    if isinstance(queue_data, dict):
                        sample_values = list(queue_data.values())[:5]
                        # Jakŝo je "maybe", "mfirst", "msecond" - ce proğnoz, propuskajemo
                        if any(val in ["maybe", "mfirst", "msecond"] for val in sample_values if isinstance(val, str)):
                            if DEBUG:
                                print(f"⏭️ Propuskaju proğnozni dani z patternu {pattern[:40]}...")
                            continue
                        
                        if DEBUG:
                            print(f"✅ Znajdeno aktualjnyj ğrafik čerez pattern: {pattern[:40]}...")
                        return queue_data
                        
            except json.JSONDecodeError:
                continue
    
    # Probujemo znajty vsi ob'jekty z našoju čerğoju i vybraty aktualjnyj
    all_patterns = [
        r'"' + re.escape(queue_id) + r'":\s*\{([^}]+)\}',
    ]
    
    candidates = []
    for pattern in all_patterns:
        matches = re.finditer(pattern, html_text)
        for match in matches:
            inner_json = '{' + match.group(1) + '}'
            try:
                data = json.loads(inner_json)
                # Perevirjajemo typ danyx
                sample_values = list(data.values())[:5]
                has_forecast = any(val in ["maybe", "mfirst", "msecond"] for val in sample_values if isinstance(val, str))
                
                if not has_forecast:
                    candidates.append(data)
                    
            except json.JSONDecodeError:
                # Probujemo ručnyj parsynğ
                inner_content = match.group(1)
                pairs = re.findall(r'"(\d+)"\s*:\s*"(\w+)"', inner_content)
                if pairs:
                    data = {key: value for key, value in pairs}
                    sample_values = list(data.values())[:5]
                    has_forecast = any(val in ["maybe", "mfirst", "msecond"] for val in sample_values)
                    
                    if not has_forecast:
                        candidates.append(data)
    
    # Povertajemo peršyj znajdenyj aktualjnyj ğrafik
    if candidates:
        if DEBUG:
            print(f"✅ Znajdeno {len(candidates)} variantiv, vykorystovuju peršyj aktualjnyj")
        return candidates[0]
    
    # Jakŝo ničoğo ne znajšly, šukajemo budj-jaki dani dlja diağnostyky
    return None

def get_full_schedule():
    headers = {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language": "uk,en;q=0.5",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
    }

    try:
        if DEBUG:
            print(f"🔍 Zapyt do {URL}...")
        
        response = requests.get(URL, headers=headers, timeout=15)
        response.raise_for_status()
        
        if DEBUG:
            print(f"✅ Otrymano {len(response.text)} symvoliv\n")
        
        # Vytjağujemo aktualjnyj ğrafik
        data_dict = extract_current_schedule(response.text, TARGET_QUEUE)

        if not data_dict:
            print(f"❌ Ne vdalosja znajty aktualjnyj ğrafik dlja {TARGET_QUEUE}.")
            
            if DEBUG:
                print("\n🔍 Pokazuju vsi znajdeni dani dlja diağnostyky...")
                all_matches = re.finditer(r'"' + re.escape(TARGET_QUEUE) + r'":\s*\{([^}]+)\}', response.text)
                for i, match in enumerate(all_matches, 1):
                    print(f"\n--- Variant {i} ---")
                    print(match.group(0)[:200])
            
            # Pokazujemo dostupni čerğy
            print("\n🔍 Pošuk dostupnyx čerğ na storinci...")
            queues = re.findall(r'"(GPV\d+\.?\d*)":', response.text)
            unique_queues = sorted(set(queues))
            
            if unique_queues:
                print(f"Znajdeno čerğy: {', '.join(unique_queues[:20])}")
            
            return

        # Vyvodymo ğrafik
        current_time = datetime.now()
        print(f"📅 Aktualjnyj ğrafik dlja čerğy {TARGET_QUEUE.replace('GPV', '')} na {current_time.strftime('%d.%m.%Y')}:")
        print("=" * 41)
        
        # Vyvid ğodyn
        found_hours = 0
        for h in range(1, 25):
            status = data_dict.get(str(h), None)
            
            if status is None:
                status = data_dict.get(h, "unknown")
            
            # Vyznačajemo ikonku dlja AKTUALJNOĞO ğrafika
            # V aktualjnomu ğrafiku: "yes" = svitlo je, "no" = svitla nemaje
            if status == "yes" or status == "1" or status is True:
                icon = "🟢 Svitlo je"
                found_hours += 1
            elif status == "no" or status == "0" or status is False:
                icon = "❌ Svitla nemaje"
                found_hours += 1
            else:
                # Jakŝo znajšly "maybe", "mfirst" toŝo - ce pomylka, my vzjaly ne ti dani
                if status in ["maybe", "mfirst", "msecond"]:
                    print(f"\n⚠️ UVAĞA: Sxože skrypt vzjav proğnozni dani zamistj aktualjnyx!")
                    print(f"Sprobuj zapustyty z --debug dlja diağnostyky\n")
                icon = f"❓ Nevidomo"
            
            # Vydiljajemo potočnu ğodynu
            current_hour = current_time.hour
            prefix = "▶" if h-1 == current_hour else "  "
            suffix = " " if h-1 == current_hour else ""
            
            print(f"{prefix}{h-1:02d}:00 - {h:02d}:00  —  {icon}{suffix}")
        
        if DEBUG:
            print(f"\n✅ Znajdeno {found_hours}/24 ğodyn z validnym statusom")
            print(f"📊 Syri dani: {data_dict}")

    except requests.exceptions.RequestException as e:
        print(f"❌ Pomylka z'jednannja: {e}")
        print("\n💡 Perevir:")
        print("  - Internet-z'jednannja")
        print("  - Dostupnistj sajtu dtek-dnem.com.ua")
        
    except Exception as e:
        print(f"❌ Pomylka: {e}")
        
        if DEBUG:
            import traceback
            traceback.print_exc()

if __name__ == "__main__":
    if "--help" in sys.argv or "-h" in sys.argv:
        print("""
Vykorystannja: python3 dtek_final.py [opciï]

Opciï:
  --debug    Pokazaty detaljnu diağnostyčnu informaciju
  --help     Pokazaty cju dovidku
  
Pryklady:
  python3 dtek_final.py           # Zvyčajnyj zapusk
  python3 dtek_final.py --debug   # Z diağnostykoju
        """)
    else:
        get_full_schedule()
