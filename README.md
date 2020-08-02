# github-action-react

- #### Tecnologías:
    - Git
    - Make
    - Docker

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

    ![Example 1]()

