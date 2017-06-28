#/bin/bash
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
Docker_Name="php-apache"
Container_Name="php-apache"

case "$1" in
  clear)
    docker rm -f $Container_Name; 
    docker rmi -f $Docker_Name ; 
    exit 0
    ;;
  debug)
    docker rm -f $Container_Name; 
    docker run --name $Container_Name -v $SCRIPT_PATH/data/:/data -it -p 80:80 $Docker_Name /bin/bash
    exit 0
    ;;
  example)
    docker rm -f $Container_Name; 
    docker run --name $Container_Name -v $SCRIPT_PATH/data/www:/var/www -d -p 80:80 $Docker_Name
    #顯示所有container
    docker ps
    #進入Container
    docker exec -it $Container_Name /bin/bash
    exit 0
    ;;
  build)
    docker rm -f $Container_Name ; 
    docker rmi -f $Docker_Name ; 
    docker build -t="$Docker_Name" $SCRIPT_PATH
    exit 0
    ;;
  *)
    echo "./build.sh {build|debug|example|clear}";
    exit 1
    ;;
esac
  
exit 0

#cp /etc/php/7.0/apache2/php.ini /data/php/apache2/php.ini
#cp /etc/php/7.0/cli/php.ini /data/php/cli/php.ini
#cp /etc/php/7.0/cli/php.ini^C
#cp /etc/mysql/my.cnf /data/mariadb/my.cnf 
#cp /etc/mysql/conf.d/mariadb.cnf /data/mariadb/mariadb.cnf
