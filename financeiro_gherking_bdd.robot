*** Settings ***
Documentation    Essa suíte testa o site https://seubarriga.wcaquino.me/login
Resource         autenticação.robot
Resource         ./conta.robot
Resource         ./gherking_ptbr.robot
Resource         financeiro.hook.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador  


*** Test Cases ***
Caso de Teste 01 - Validando mensagem de E-mail já cadastrado 
    [Documentation]    Esse teste valida mensagem de E-mail já cadastrado
    [Tags]    TC001        
    Dado que estou na home page do Seu Barriga
    Quando clicar em "Novo Usuário?"
    E criar um novo usuário
    Então deve aparecer "Endereço de email já utilizado"
    
Caso de teste 02 - Criando novo usuário
     [Documentation]   Esse teste valida a criação de um novo usuário 
    [Tags]    TC002
    Dado que estou na home page do Seu Barriga
    Quando clicar em "Novo Usuário?"
    E criar um novo usuário com e-mail "Fake"
    Então deve cadastrar com sucesso 

Caso de test 03 - Fazer Login
  [Documentation]   Esse teste valida se está logado na home page do Seu Barriga
    [Tags]    TC003 
    Dado que estou logado na home page do Seu Barriga
    Então verificar se está logado


Caso de test 04 - Adicionar conta e excluir 
  [Documentation]   Esse teste valida a adição e exclusão de conta 
    [Tags]    TC004 
    Dado que estou logado na home page do Seu Barriga
    Quando adicionar conta "Nova"
    E verificar se a conta foi adicionada 
    Então excluir conta

Caso de teste 05 - Adicionar conta com mesmo nome
  [Documentation]   Esse teste valida a adição de conta com mesmo nome 
    [Tags]    TC005
    Dado que estou logado na home page do Seu Barriga
    Quando adicionar conta "Nova"
    E adicionar outra conta "Nova"
    E verificar se já possui conta com esse nome 
    Então excluir conta

Caso de teste 06 - Alterar nome da conta   
  [Documentation]   Esse teste valida alteração do nome da conta
    [Tags]    TC006
    Dado que estou logado na home page do Seu Barriga
    Quando adicionar conta "Nova"
    E alterar o nome "Nova" para "Atual"
    E verificar se a conta foi alterada com sucesso
    Então excluir conta
    

Caso de teste 07 - Criar movimentações do tipo Despesa e Receita 
  [Documentation]   Esse teste valida a criação de duas movimentações
  ...               do tipo Despesa e Receita
    [Tags]    TC007
    Dado que estou Logado na home page do Seu Barriga
    Quando adicionar conta "Nova"
    E criar movimentação do tipo "Receita" e da situação "Pago" 
    E verificar se a movimentação foi adicionada com sucesso 
    E criar movimentação do tipo "Despesa" e da situação "Pendente"
    E verificar se a movimentação foi adicionada com sucesso
    E excluir a primeira conta  
    E verificar se aparece a mensagem "Conta em uso na movimentações"
    E remover as duas movimentações 
    Então excluir conta


Caso de teste 08 - Busca de movimentação
  [Documentation]   Esse teste valida a busca de uma movimentação criada 
    [Tags]    TC008    
   Dado que estou Logado na home page do Seu Barriga
   Quando adicionar conta "Nova"
   E criar movimentação do tipo "Receita" e da situação "Pago" 
   E verificar se a movimentação foi adicionada com sucesso
   E buscar pela data de Janeiro de 2023
   E verificar se aparece a movimentação
   E remover movimentação
   E excluir conta
   Então sair 


  
    








