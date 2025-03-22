#!/bin/bash

total_requests=$(wc -l < access.log)

unique_ips=$(awk '{print $1}' access.log | sort -u | wc -l)

methods=$(awk '{print $6}' access.log | tr -d '"' | sort | uniq -c)

get_requests=$(echo "$methods" | grep "GET" | awk '{print $1}')
post_requests=$(echo "$methods" | grep "POST" | awk '{print $1}')

popular_url=$(awk -F'"' '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 1)

{
    echo "Отчет о логе веб-сервера"
    echo "========================"
    echo "Общее количество запросов: $total_requests"
    echo "Количество уникальных IP-адресов: $unique_ips"
    echo ""
    echo "Количество запросов по методам:"
    [ -z "$get_requests" ] && get_requests=0
    [ -z "$post_requests" ] && post_requests=0
    echo "$get_requests GET"
    echo "$post_requests POST" 
    echo ""
    echo "Самый популярный URL: $popular_url"
} > report.txt

echo "Отчет сохранен в файл report.txt"
