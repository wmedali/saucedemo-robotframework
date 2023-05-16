*** Settings ***
Resource            keywords.robot

Test Setup          Open Browser    https://www.saucedemo.com/    chrome
Test Teardown       Close All Browsers


*** Variables ***
${user}             standard_user
${lockedUser}       locked_out_user
${password}         secret_sauce


*** Test Cases ***
Authentification avec succès
    Location Should Be    https://www.saucedemo.com/
    Se connecter    ${user}    ${password}
    Location Should Be    https://www.saucedemo.com/inventory.html

Authentification en utilisant un nom d'utilisateur vide et un mot de passe
    Location Should Be    https://www.saucedemo.com/
    Se connecter    ${EMPTY}    ${password}
    Element Should Be Visible    class:error-message-container
    Element Should Contain    class:error-message-container    Epic sadface: Username is required

Authentification avec un nom d'utilisateur et un mot de passe vide
    Location Should Be    https://www.saucedemo.com/
    Se connecter    ${user}    ${EMPTY}
    Element Should Be Visible    class:error-message-container
    Element Should Contain    class:error-message-container    Epic sadface: Password is required

Authentification avec un utilisateur bloqué locked_out_user
    Location Should Be    https://www.saucedemo.com/
    Se connecter    ${lockedUser}    ${password}
    Element Should Be Visible    class:error-message-container
    Element Should Contain    class:error-message-container    Epic sadface: Sorry, this user has been locked out.
