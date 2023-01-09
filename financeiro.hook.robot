*** Settings ***
Library    SeleniumLibrary


*** Keywords ***
Abrir o navegador   
    Open Browser    browser=chrome
    Maximize Browser Window 
    Go To    url=https://seubarriga.wcaquino.me/login

Fechar o navegador
    Close Browser    

