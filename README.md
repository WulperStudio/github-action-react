# github-action-react

- #### Tecnologías y/o Conocimientos:
    - Git
    - Make
    - Docker
    - Docker Compose
    - Github
    - DigitalOcean

- #### Creación del proyecto:

    1) Abrir la terminal (shell).

    2) Crear el proyecto con **create-react-app**.

    ```
    $ npx create-react-app github-action-react --template typescript
    ```

- #### Crear configuración para github actions

    1) Ir al directorio raíz del proyecto.

    2) Crear la siguiente estructura de carpetas:

    ```
    $ mkdir -p .github/workflows
    ```

    3) Crear el archivo *main.yml* (archivo de configuración YAML) dentro de la carpeta recién creada *workflows*:

    ```
    $ touch main.yml
    ```

    4) llenarlo con el siguiente contenido:

    ---
        name: github-action-react
        on:
            push:
                branches: [ master ]
            pull_request:
                branches: [ master ]
        jobs:
            deploy:
                runs-on: ubuntu-latest
                steps:
                - uses: actions/checkout@master
                - name: deploy
                uses: alinz/ssh-scp-action@master
                env:
                    HELLO: word
                with:
                    key:  ${{ secrets.PRIVATE_KEY }}
                    host: ${{ secrets.REMOTE_HOST }}
                    port: ${{ secrets.REMOTE_PORT }}
                    user: ${{ secrets.REMOTE_USER }}
                    ssh_before: |
                        echo $HELLO
                        make -C /home -f deploy.mk update
    ---

    5) Subir los cambios al repositorio en *github.com*

    6) Detro del repositorio ir a la opción **Settings**/**Secrets**

    ![Example 1](https://raw.githubusercontent.com/WulperStudio/github-action-react/master/docs/secrects.png)

    7) Crear las claves secretas con las credenciales y contraseñas para los accesos del despliegue:<br><br>

    Clave              | Valor
    ---------------    | ---------------
    PRIVATE_KEY        | Llave privada del droplet (instancia)
    REMOTE_FINGERPRINT | Fingerprint de la cuenta de [DigitalOcean](https://www.digitalocean.com)
    REMOTE_HOST        | Host (**IP**) del droplet (instancia)
    REMOTE_PORT        | Puerto de entrada (22 generalmente) del droplet (instancia)
    REMOTE_USER        | Usuario (root)  del droplet (instancia)
