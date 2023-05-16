*** Settings ***
Library         FakerLibrary
Library         LibTestStr.py
Resource        keywords.robot

Test Setup      Open Browser    https://www.saucedemo.com/    chrome


*** Variables ***
${user}         standard_user
${password}     secret_sauce


*** Test Cases ***
Test de bout en bout avec achat de produit
    Location Should Be    https://www.saucedemo.com/
    Se connecter    ${user}    ${password}
    Location Should Be    https://www.saucedemo.com/inventory.html
    ${productName}=    Get Text    id:item_1_img_link
    Click Button    data:test:add-to-cart-sauce-labs-bolt-t-shirt
    Element Should Contain    data:test:remove-sauce-labs-bolt-t-shirt    Remove
    Click Element    class:shopping_cart_container
    Element Should Be Visible    class:inventory_item_name
    Element Should Contain    class:inventory_item_name    ${productName}
    ${productPrice}=    Get Text    class:inventory_item_price
    ${productPriceClean}=    Clean Phrase    ${productPrice}
    ${productQuantity}=    Get Text    class:cart_quantity
    Click Button    data:test:checkout
    ${firstName}=    FakerLibrary.First Name
    ${lastName}=    FakerLibrary.Last Name
    ${zipCode}=    FakerLibrary.Zipcode
    Input Text    data:test:firstName    ${firstName}
    Input Text    data:test:lastName    ${lastName}
    Input Text    data:test:postalCode    ${zipCode}
    Click Button    data:test:continue
    ${value}=    evaluate    ${productPriceClean} * ${productQuantity}
    Element Should Contain    class:summary_subtotal_label    ${value}
    Click Button    data:test:finish
    Location Should Be    https://www.saucedemo.com/checkout-complete.html
    Element Should Be Visible    class:complete-header
    Element Should Contain    class:complete-header    Thank you for your order!
