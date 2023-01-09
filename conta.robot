
*** Settings ***
Library     SeleniumLibrary
Library    FakerLibrary

*** Variables ***
&{movimentacao}
#TEXT
...   TXT_CONTA_ADICIONADA=//div[contains(.,'Conta adicionada com sucesso!')]
...   TXT_CONTA_REMOVIDA=//div[contains(.,'Conta removida com sucesso!')]
...   TXT_CONTA_JA_EXISTE=//div[contains(.,'Já existe uma conta com esse nome!')]
...   TXT_CONTA_ALTERADA=//div[contains(.,'Conta alterada com sucesso!')]
...   TXT_MOVIMENTACAO_ADICIONADA=//div[contains(.,'Movimentação adicionada com sucesso!')]
...   TXT_CONTA_EM_USO=//div[contains(.,'Conta em uso na movimentações')]
...   TXT_DATA=//td[contains(.,'04/01/2023')]


#INPUT
...    IPT_NOME_CONTA=//input[contains(@type,'text')]
...    IPT_TIPO=//select[@name='tipo']
...    IPT_DESCRICAO=//input[@name='descricao']
...    IPT_VALOR=//input[@name='valor']
...    IPT_MOVIMENTACAO=//input[contains(@name,'transacao')]
...    IPT_PAGAMENTO=//input[contains(@name,'pagamento')]
...    IPT_INTERESSADO=//input[@name='interessado']
...    IPT_BUSCAR=//select[@name='mes']
...    IPT_LOGIN=//a[contains(.,'Login')]

#BUTTON
...    BTN_CONTAS=//a[contains(@class,'dropdown-toggle')]
...    BTN_ADICIONAR=//a[contains(.,'Adicionar')]
...    BTN_SALVAR=//button[contains(.,'Salvar')]
...    BTN_LISTAR=//a[contains(.,'Listar')]
...    BTN_REMOVER_CONTA=//span[@class='glyphicon glyphicon-remove-circle']
...    BTN_EDITAR_NOME_CONTA=//span[@class='glyphicon glyphicon-edit']
...    BTN_CRIAR_MOVIMENTACAO=//a[contains(.,'Criar Movimentação')]
...    BTN_RESUMO_MENSAL=//a[contains(.,'Resumo Mensal')]
...    BTN_TIPO=//select[@name='tipo']
...    BTN_TIPO_RECEITA=//option[contains(.,'Receita')]
...    BTN_TIPO_DESPESA=//option[contains(.,'Despesa')]
...    BTN_BUSCAR=//input[@type='submit']
...    BTN_SAIR=//a[contains(.,'Sair')]


#COMBO
...    CMB_MES=//select[@name='mes']
...    CMB_MES_JANEIRO=//option[contains(.,'Janeiro')]
...    CMB_ANO=//select[contains(@name,'ano')]
...    CMB_ANO_2023=//option[contains(.,'2023')]
...    CMB_CONTA=//select[@name='conta']

#    RADIO_BUTTON
...    RBT_SITUACAO_PAGO=//input[contains(@id,'pago')]
...    RBT_SITUACAO_PENDENTE=//input[contains(@id,'pendente')]


*** Keywords ***
#                                        Caso de teste 04 - Adicionar conta e excluir  

adicionar conta "Nova"
    Click Element     ${movimentacao.BTN_CONTAS}
    Click Element     ${movimentacao.BTN_ADICIONAR}
    Input Text        ${movimentacao.IPT_NOME_CONTA}    Nova
    Click Button      ${movimentacao.BTN_SALVAR}
    
verificar se a conta foi adicionada     
    Wait Until Element Is Visible     ${movimentacao.TXT_CONTA_ADICIONADA}    timeout=30s
excluir conta
    Click Element                    ${movimentacao.BTN_CONTAS}
    Click Element                    ${movimentacao.BTN_LISTAR}
    Click Element                    ${movimentacao.BTN_REMOVER_CONTA}
    Wait Until Element Is Visible    ${movimentacao.TXT_CONTA_REMOVIDA} 



  #                                    Caso de teste 05 - Adicionar conta com mesmo nome   
adicionar outra conta "Nova"
    Click Element   ${movimentacao.BTN_CONTAS}
    Click Element   ${movimentacao.BTN_ADICIONAR}
    Input Text      ${movimentacao.IPT_NOME_CONTA}    Nova
    Click Button    ${movimentacao.BTN_SALVAR}

verificar se já possui conta com esse nome 
    Wait Until Element Is Visible     ${movimentacao.TXT_CONTA_JA_EXISTE}



#                                      Caso de teste 06 - Alterar nome da conta 
alterar o nome "Nova" para "Atual"
    Click Element    ${movimentacao.BTN_EDITAR_NOME_CONTA}
    Input Text       ${movimentacao.IPT_NOME_CONTA}    Atual
    Click Button     ${movimentacao.BTN_SALVAR}

verificar se a conta foi alterada com sucesso
    Wait Until Element Is Visible    ${movimentacao.TXT_CONTA_ALTERADA}



#                                       Caso de teste 07 - Criar movimentação Despesa

criar movimentação do tipo "${tipo}" e da situação "${situação}"
    Click Element        ${movimentacao.BTN_CRIAR_MOVIMENTACAO}
    Click Element        ${movimentacao.BTN_TIPO}
    IF    "${tipo}" == "Receita"
        Click Element    ${movimentacao.BTN_TIPO_RECEITA}
    ELSE
        Click Element    ${movimentacao.BTN_TIPO_DESPESA}
    END
# Descrição
    Input Text       ${movimentacao.IPT_DESCRICAO}    Férias 
# Valor   
    Input Text       ${movimentacao.IPT_VALOR}    1000
# Data da movimentação    
    Input Text       ${movimentacao.IPT_MOVIMENTACAO}    03/01/2022
# Data do pagamento    
    Input Text       ${movimentacao.IPT_PAGAMENTO}     04/01/2023
# Conta    
    Click Element    ${movimentacao.CMB_CONTA}
# Interessado
    Input Text       ${movimentacao.IPT_INTERESSADO}    Luana
# Situação
    IF    "${situação}" == "Pago"
        Click Element    ${movimentacao.RBT_SITUACAO_PAGO}
    ELSE
        Click Element    ${movimentacao.RBT_SITUACAO_PENDENTE}
    END

    Click Button         ${movimentacao.BTN_SALVAR}

verificar se a movimentação foi adicionada com sucesso
    Wait Until Element Is Visible    ${movimentacao.TXT_MOVIMENTACAO_ADICIONADA}

excluir a primeira conta     
    Click Element    ${movimentacao.BTN_CONTAS}
    Click Element    ${movimentacao.BTN_LISTAR}
    Click Element    ${movimentacao.BTN_REMOVER_CONTA}
    
verificar se aparece a mensagem "Conta em uso na movimentações"
    Wait Until Element Is Visible     ${movimentacao.TXT_CONTA_EM_USO}    timeout=30s  

remover as duas movimentações    
    Click Element    ${movimentacao.BTN_RESUMO_MENSAL}
    Click Element    ${movimentacao.BTN_REMOVER_CONTA}
    Click Element    ${movimentacao.BTN_REMOVER_CONTA}    
    

    #                                           Caso de teste 08 - Busca de movimentação
buscar pela data de Janeiro de 2023
    Click Element    ${movimentacao.BTN_RESUMO_MENSAL}
    Click Element    ${movimentacao.CMB_MES}
    Click Element    ${movimentacao.CMB_MES_JANEIRO}
    Click Element    ${movimentacao.CMB_ANO}
    Click Element    ${movimentacao.CMB_ANO_2023}
    Click Button     ${movimentacao.BTN_BUSCAR}

verificar se aparece a movimentação
    Wait Until Element Is Visible    ${movimentacao.TXT_DATA}

remover movimentação    
    Click Element    ${movimentacao.BTN_RESUMO_MENSAL}
    Click Element    ${movimentacao.BTN_REMOVER_CONTA}

sair 
    Click Element                     ${movimentacao.BTN_SAIR}
    Wait Until Element Is Visible     ${movimentacao.IPT_LOGIN}
    
    






    