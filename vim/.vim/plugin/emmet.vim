let g:user_emmet_leader_key = ','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

let g:user_emmet_settings = {
\  'variables': { 'lang': 'en' },
\  'html': {
\    'default_attributes': {
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."\t<title></title>\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\       'link:css': "<link rel=\"stylesheet\" href=\"${cursor}\">",
\       'script:js': "<script src=\"${cursor}\" type=\"text/javascript\"></script>"
\    },
\  },
\}
