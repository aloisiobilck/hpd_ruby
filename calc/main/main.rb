# encoding: utf-8

require 'calc/lib/calculadora'
require 'logger'

calculadora = Calculadora.new
logger = Logger.new('../log/calc.log')   
finalizado = false
opcao_valida = false
eh_numero = false
operacao_valida = false

# Interacao com usuario 

File.open('../resources/intro.txt') do |f|
  f.each_line do |line|
    puts line
  end
end
                                                                                      
while !eh_numero
    puts "\n> Digite um número para realizar uma operação matemática:"
    begin
    numero1 = Float(gets)
    eh_numero = true
    rescue ArgumentError => e
        puts e.message
        puts '> Erro: Você precisa digitar um número!'
        logger.add(Logger::ERROR) { "Usuário não digitou um número válido. #{e.message}" }
    end
end

eh_numero = false

while !finalizado do
    while !operacao_valida
        puts "\n> Digite uma das operações disponíveis:"
        calculadora.opcoes.each_value {|value| puts "> [ #{value} ]"}
        operacao = gets.to_str.strip   
        case operacao
        when '-', '+', '*', '/'
            operacao_valida = true  
        else
            logger.add(Logger::ERROR) { "Usuário não digitou uma operação disponível: #{operacao}" }
        end
    end
    operacao_valida = false    
    while !eh_numero
        puts "\n> Digite outro número para aplicar na expressão: #{numero1} #{operacao} "
        begin    
        numero2 = Float(gets)
        eh_numero = true
        rescue ArgumentError => e
            puts e.message
            puts '> Erro: Você precisa digitar um número!'
            logger.add(Logger::ERROR) { "Usuário não digitou um número válido. #{e.message}" }
        end
    end
    eh_numero = false        
    begin
    total = calculadora.realiza_calculo(numero1, operacao, numero2)
    puts "\n> RESULTADO: #{numero1} #{operacao} #{numero2} = #{total}"
    logger.add(Logger::ERROR) { "Cálculo realizado: #{numero1} #{operacao} #{numero2} = #{total}" }
    rescue ZeroDivisionError => e
        puts e.message
        total=numero1
        logger.add(Logger::ERROR) { "Usuário tentou realizar uma divisão por zero: #{numero1} #{operacao} #{numero2} #{e.message}" }
    end
    while !opcao_valida do
        puts "\n> Deseja continuar o cálculo? [S/N]"
        quer_continuar = gets.to_str.strip
        case quer_continuar
        when 'S', 's'
            opcao_valida = true
            puts "\n > Valor salvo: #{total}"
            numero1 = total
        when 'N', 'n'
            opcao_valida = true
            finalizado = true
            logger.add(Logger::INFO) { 'Usuário encerrou o programa.' }
        end
    end
    opcao_valida = false
end
