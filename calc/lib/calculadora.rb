class Calculadora

    def initialize
    @opcoes = {soma: "+", subtracao: "-", multiplicacao: "*", divisao: "/"}
    end

    def soma(parcela1, parcela2)
        parcela1+parcela2
    end

    def subtrai(minuendo, subtraendo)
        minuendo-subtraendo
    end

    def subtrai(minuendo, subtraendo)
        minuendo-subtraendo
    end

    def divide(dividendo, divisor)
        if divisor == 0
            raise ZeroDivisionError, '> Divisão por zero é indefinida'
        end    
        dividendo/divisor
    end

    def multiplica(multiplicando, multiplicador)
        multiplicando*multiplicador
    end

    def opcoes
        @opcoes
    end

    def realiza_calculo(numero1, operacao, numero2)

    total = 0;
    case operacao
    when '-'
        total=subtrai(numero1,numero2)
    when '+'
        total=soma(numero1,numero2)
    when '/'
        total=divide(numero1,numero2)
    when '*'
        total=multiplica(numero1,numero2)
    end
    return total
    end
end

