# nginx-log-analyzer
simple script to check for request that where blocked by nginx 403 rules<br>

there are a lot of tools available that can do this for you much better, but this is just a simple script which maybe helpfull to you in some situations<br>

1. if your conf files are in a directory other than /etc/nginx/conf.d then change line 14 to your directory <br>
2. the script checks log files with this format ( domain.com_error.log ) domain.com is taken from server_name in conf files and log file should be in /var/log/nginx/, if you save your log files with diffrent names or in a diffrent directory, you should change line 19 to match your settings.<br>
this is en example output, which goes to next host after pressing Enter:<br>
```

Checking logs for sub.domain.com
2 requests from 1.1.1.1 on /
2 requests from 123.133.225.32 on /
2 requests from 163.218.193.111 on /
2 requests from 129.172.13.18 on /
1 requests from 61.68.117.115 on /owa/
1 requests from 61.60.177.134 on /
1 requests from 61.63.190.25 on /owa/
1 requests from 61.69.191.151 on /
1 requests from 49.194.114.117 on ///remote/fgt_lang?lang=/../../../..//////////dev/
1 requests from 11.221.104.45 on /owa/auth/logon.aspx?url=https%3a%2f%2f1%2fecp%2f
1 requests from 158.49.1.121 on /
1 requests from 113.126.225.39 on /robots.txt
1 requests from 113.126.15.31 on /favicon.ico
1 requests from 110.68.128.212 on /
1 requests from 109.192.41.189 on /favicon.ico
1 requests from 12.150.10.112 on /
1 requests from 116.95.197.114 on /
Press any key to continue to the next host..
```
