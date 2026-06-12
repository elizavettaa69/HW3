import csv
import random
import os
import sys

NUM_ROWS = 50
COLUMNS = ["student", "sleep_hours","platform" "memes_watched"]

def generate_row():
    names = ["Лизочка", "Юрий", "Лариса", "Альберт", "Ангелина", "Георгий", "Тамерлан", "Адам", "Анастасия"]
    anxieties = ["спокойный", "небольшой страх", "страшно", "паника"]
    platforms = ["TikTok", "Instagram reels", "YouTube Shorts"]
    return {
         "student": random.choice(names),
         "sleep_hours": random.randint(1, 12),
         "memes_watched": random.randint(0, 1000),
         "platform": random.choice(platforms)
         
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)
