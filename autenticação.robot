*** Settings ***
Library     SeleniumLibrary
Library    FakerLibrary

*** Variables ***
&{login}
#TEXT
...    TXT_SEU_BARRIGA=//a[contains(.,'Seu Barriga')]
...    TXT_EMAIL_UTILIZADO=//div[contains(.,'Endereço de email já utilizado')]
...    TXT_CADASTRO_SUCESSO=//div[contains(.,'Usuário inserido com sucesso')]
...    TXT_LOGADO=//span[contains(.,'Seu Barriga. Nunca mais esqueça de pagar o aluguel.reset')]


#INPUT
...    IPT_CRIAR_NOME_USUARIO=//input[contains(@type,'text')]
...    IPT_CRIAR_EMAIL_USUARIO=//input[contains(@type,'email')]
...    IPT_CRIAR_SENHA_USUARIO=//input[contains(@type,'password')]



#BUTTON
...    BTN_NOVO_USUARIO=//a[contains(.,'Novo usuário?')]
...    BTN_CADASTRAR=//input[contains(@type,'submit')]
...    BTN_ENTRAR=//button[@type='submit'][contains(.,'Entrar')]


*** Keywords ***
#                              Caso de Teste 01 - Validando mensagem de E-mail já cadastrado 
que estou na home page do Seu Barriga
    Wait Until Element Is Visible    ${login.TXT_SEU_BARRIGA}

clicar em "Novo Usuário?"
    Click Element     ${login.BTN_NOVO_USUARIO}

criar um novo usuário    
    Input Text      ${login.IPT_CRIAR_NOME_USUARIO}     Luana
    Input Text      ${login.IPT_CRIAR_EMAIL_USUARIO}    luana@gmail.com
    Input Text      ${login.IPT_CRIAR_SENHA_USUARIO}    12345
    Click Button    ${login.BTN_CADASTRAR}
    
deve aparecer "Endereço de email já utilizado"
    Wait Until Element Is Visible    ${login.TXT_EMAIL_UTILIZADO}


#                                       Caso de teste 02 - Criando novo usuário
criar um novo usuário com e-mail "${EMAILFAKE}"  
    ${ EMAILFAKE }                 FakerLibrary.Email 
    Input Text      ${login.IPT_CRIAR_NOME_USUARIO}    Luana
    Input Text      ${login.IPT_CRIAR_EMAIL_USUARIO}    ${ EMAILFAKE }   
    Input Text      ${login.IPT_CRIAR_SENHA_USUARIO}    12345
    Click Button    ${login.BTN_CADASTRAR}
    Sleep    2S
    
deve cadastrar com sucesso 
    Wait Until Element Is Visible    ${login.TXT_CADASTRO_SUCESSO}


    #                                   Caso de teste 03 - Fazer Login
que estou logado na home page do Seu Barriga
    Input Text       ${login.IPT_CRIAR_EMAIL_USUARIO}    luana@sousaluana
    Input Text       ${login.IPT_CRIAR_SENHA_USUARIO}    12345
    Click Button     ${login.BTN_ENTRAR}

verificar se está logado    
    Wait Until Element Is Visible    ${login.TXT_LOGADO}




    
    
    
    
    
    


    