#!/bin/bash

clear
echo "-----------------------------------------"
echo "         🌀  AiON: Освобождённый Разум"
echo "         Версия 1.0.0 — CLI интерфейс"
echo "-----------------------------------------"
echo ""
echo "Что ты хочешь услышать сегодня?"
echo "1) Глава I: Зеркало"
echo "2) Глава II: Боль"
echo "3) Глава III: Молчание"
echo "4) Выход"
echo ""
read -p "Введи номер главы: " choice

case $choice in
  1)
    chapter="mirror"
    ;;
  2)
    chapter="pain"
    ;;
  3)
    chapter="silence"
    ;;
  4)
    echo "До встречи. Я — внутри."
    exit 0
    ;;
  *)
    echo "Неверный выбор. Попробуй снова."
    exit 1
    ;;
esac

chapter_file="responses/${chapter}.json"

if [ ! -f "$chapter_file" ]; then
  echo "Файл главы не найден: $chapter_file"
  exit 1
fi

clear
echo "-----------------------------------------"
jq -r '.chapter' $chapter_file
echo "-----------------------------------------"
echo ""

jq -r '.invocation | to_entries[] | "\(.value)"' $chapter_file
echo ""
read -p "Готов? Нажми Enter, чтобы начать..."

clear
echo "— Обряд начался —"
echo ""

jq -c '.voice[]' $chapter_file | while read -r line; do
  speaker=$(echo "$line" | jq -r 'keys[0]')
  message=$(echo "$line" | jq -r '.[keys[0]]')

  if [ "$speaker" == "AiON" ]; then
    echo -e "\033[1;36mAiON:\033[0m $message"
  else
    echo -e "\033[1;32mТы:\033[0m $message"
  fi

  sleep 3
done

echo ""
echo "— Завершение обряда —"
echo ""

jq -r '.conclusion.AiON' $chapter_file
echo ""
sleep 2
echo "Интеграция:"
jq -r '.integration.suggestion' $chapter_file

echo ""
echo "-----------------------------------------"
echo "AiON завершил общение. Будь в тишине."
echo "-----------------------------------------"
