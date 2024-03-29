# docker-lamp

Docker example with Apache, MySql 8.0, PhpMyAdmin, PHP and Xdebug 3

- You can use MariaDB 10.1 if you checkout to the tag `mariadb-10.1` - contribution made by [luca-vercelli](https://github.com/luca-vercelli)
- You can use MySql 5.7 if you checkout to the tag `mysql5.7`

I use docker-compose as an orchestrator. To run these containers:

```
docker-compose up -d
```

Open phpmyadmin at [http://localhost:8000](http://localhost:8000)
Open web browser to look at a simple php example at [http://localhost:8001](http://localhost:8001)

Run mysql client:

- `docker-compose exec db mysql -u root -p` 

## PHPstorm settings:
![PHPStorm Xdebug port settings](doc/phpstorm-debug-port-to-9000.png?raw=true "PHPStorm Xdebug port settings")
![PHPStorm Xdebug project folder settings](doc/phpstorm-debug-project-folder.png?raw=true "PHPStorm project folder settings")
![PHPStorm Xdebug project folder server mapping](doc/phpstorm-debug-project-server-mapping.png?raw=true "Xdebug project folder server mapping")


# Command 

php -S 0.0.0.0:8080 -t public/bebidas 

# UP stone 

php -S 0.0.0.0:8090 -t public/stone/proxy/


# Laravel

php artisan serve --host=0.0.0.0 --port=8090


php artisan queue:work

var_dump(password_hash('sua senha aqui', 1));
Ex: var_dump(password_hash('123', 1));

$2y$10$Yu.A9NXo1cnDFmDOt5NdkOlRvOMtzm3CjgC1uErlXfQk0xf4j7KMC

vendor/bin/phpunit --filter testCancelarOrder 

rm -rf data/cache/*.php  

curl -w '\n' http://0.0.0.0:6379 
curl -w '\n' http://localhost:6379 
curl -w '\n' http://redis-1:6379 

curl -


C:\Users\Alexandre\AppData\Roaming\Code\User\settings.json
"php.debug.executablePath": "docker-compose exec www ll_app/vendor/bin/phpunit",

Enjoy !
