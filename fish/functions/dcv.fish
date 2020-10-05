function dcv
    docker stop (docker ps -aq); or true
    docker rm (docker ps -aq); or true
    docker volume rm (docker volume ls -q); or true
    docker network rm (docker network ls -q); or true
end
