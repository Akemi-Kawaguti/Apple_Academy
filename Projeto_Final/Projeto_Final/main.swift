//
//  main.swift
//  Projeto_Final
//
//  Created by TAIS AKEMI KAWAGUTI SILVA on 14/11/25.
//
/*
 class
 Tipo de referência: várias variáveis podem apontar para a mesma instância de memória.
 Requer inicializadores personalizados para garantir que todas as propriedades sejam inicializadas.
 Propriedades podem ser modificadas.
 
 struct:
 Tipo de valor: ao ser atribuída ou passada, uma cópia é feita.
 Possui um inicializador automático gerado pelo compilador
 
 Classe (Class)
 Propósito: Definir um tipo complexo que agrupa dados (propriedades) e comportamentos (métodos/funções) em uma única entidade, que representa um conceito do mundo real ou uma abstração.
 Uso Principal: Modelar objetos complexos, onde a identidade do objeto é importante e onde a herança e o polimorfismo são necessários (comuns em desenvolvimento iOS/macOS com frameworks Cocoa e Cocoa Touch).
 Exemplo: Uma classe Pessoa com propriedades nome e idade, e métodos apresentar()
 
 Função (Function)
 Propósito: Executar uma sequência de instruções ou um cálculo e, opcionalmente, retornar um valor.
 Uso Principal: Organizar a lógica do programa em tarefas gerenciáveis, promovendo a reutilização de código e a clareza. Métodos são, essencialmente, funções associadas a um tipo.
 Exemplo: Uma função que calcula a área de um círculo ou formata um nome completo
 
 Classes parecem como metodo construtor no java
 
 */

import Foundation

print("Hello, World!")

enum tipoPersonagem: String {
    case clt = "CLT"
    case cltPremium = "CLT Premuim"
    case fariaLimier = "Faria Limier"
    
    var descrecao:String {
        switch self {
        case.clt: 
            return "Trabalhador, vive batalhas diarias, por isso é muito forte"
        case.cltPremium: 
            return "Tem mais sorte por ser premium"
        case.fariaLimier: 
            return "Ganha tudo nos discursos mais furados possiveis"
        }
    }
}

enum tipoDado {
    case atributo
    case combate
    case acao
    
    func rolar() -> Int{
        switch self {
        case .atributo:
            return Int.random(in: 1...20)
        case .combate:
            return Int.random(in: 1...12)
        case .acao:
            return Int.random(in: 1...6)
        }
    }
}

enum erroJogo: Error{
    case personagemMorto
    case vilaoMorto
    case escolhaInvalida
    
    var mensagem: String{
        switch self {
        case .personagemMorto:
            return "Seu personagem foi morto 😭"
        case .vilaoMorto:
            return "👾 Vilão foi derrotado 👾"
        case .escolhaInvalida:
            return "Digite uma opção válida 😡"
        }
    }
}
// comeco de personagem

class Personagem {
    let nome: String
    let tipo: tipoPersonagem
    var vida: Int
    var vidaMaxima: Int
    var ataque: Int
    var defesa: Int
    var nivel: Int
    var experiencia: Int
    let poder: String
    
    //init é o nome de um inicializador, uma função especial usada
    //para criar e configurar uma instância de uma classe, struct ou enum
    init(nome: String, tipo: tipoPersonagem, vida: Int, vidaMaxima: Int, ataque: Int, defesa: Int, nivel: Int, experiencia: Int, poder: String) {
        self.nome = nome
        self.tipo = tipo
        self.vida = vida
        self.vidaMaxima = vidaMaxima
        self.ataque = ataque
        self.defesa = defesa
        self.nivel = 1
        self.experiencia = 0

    }
//quando usamos um switch case dentro de uma
//classe é obrigatorio estar dentro de uma Função
    func tipoHeroi (){
        switch tipo{
        case.clt:
            self.vidaMaxima = 100
            self.vida = 100
            self.ataque = 15
            self.defesa = 10
        case.cltPremium:
            self.vidaMaxima = 70
            self.vida = 70
            self.ataque = 20
            self.defesa = 10
        case.fariaLimier:
            self.vidaMaxima = 80
            self.vida = 80
            self.ataque = 17
            self.defesa = 7
        }}
    
    func ganharExperiencia (xp: Int){
        experiencia += xp
        print("\n Você ganhou: \(xp) pontos de experiência!")
        verificarNivel()
    }
    
    func verificarNivel(){
        let xpNecessario = nivel * 100
        
        if experiencia >= xpNecessario{
            nivel += 1
            experiencia -= xpNecessario
            ataque += 3
            defesa += 2
            vida = vidaMaxima + (nivel * 10)
            
            print("Parabens😄 Voce subiu de nível 🎉")
            print("Ataque: \(ataque)")
            print("Defesa: \(defesa)")
            print("Vida: \(vida)")
        }
    }
    
    func atacar() -> Int{
        let dado = tipoDado.combate.rolar()
        let dano = ataque + dado + (nivel * 2)
        return dano
    }
    
    func defender(dano:Int){
        let danoReal = max(0,dano - defesa)
        vida -= danoReal
        
        if danoReal > 0 {
            print("Ai! Você recebeu \(danoReal) de dano ⚔")
            print("Vida: \(vida/vidaMaxima)")
        } else {
            print("Sua defesa bloqueou o ataque 🛡")
        }
    }
    
    func mostrarStatus() {
        print("----------------------------------")
        print("Heroi: \(nome) - \(tipo)")
        print("Nivel: \(nivel) - \(poder)")
        print("Vida: \(vida) - \(vidaMaxima)")
        print("Ataque: \(ataque) - Defesa: \(defesa) - XP: \(experiencia)")
        print("----------------------------------")
    }
}

// comeco do Vilao

    class Vilao{
        let nome: String
        let tipo: String
        var vida: Int
        let ataque: Int
        let fraqueza: String
        let recompensaXP: Int
        
        init(nome: String, tipo: String, vida: Int, ataque: Int, fraqueza: String, recompensaXP: Int) {
            self.nome = nome
            self.tipo = tipo
            self.vida = vida
            self.ataque = ataque
            self.fraqueza = fraqueza
            self.recompensaXP = recompensaXP
        }
        
        func atacar () -> Int{
            let dado = tipoDado.combate.rolar()
            return ataque + dado
        }
        
        func receberDano (dano: Int){
            vida -= dano
            
            if vida > 0 {
                print("Você causou dor nele também, \(dano) dano")
            }
        }
        
        func mostrarInfo(){
            print("----------------------------------")
            print("Vilão: \(nome) - \(tipo) 🧟‍♀️")
            print("Vida: \(vida)")
            print("Ataque: \(ataque) - Fraqueza: \(fraqueza)")
            print("----------------------------------")
        }
        
        class GeradorViloes{
            func gerarVilao(nivelHeroi:Int) -> Int {
                let viloes = [
                    ("Boleto","Atrasado", 40, 10, "Memória boa", 70),
                    ("Tigrinho","Mau carater", 30, 6, "Consciencia", 90),
                    ("Dor","Costas, Joelho", 20, 5, "Exercicios fisicos", 110),
                    ("Ressaca","Bebado", 10, 7, "Beber água", 100),
                    ("Insonia","Noturno", 30, 10, "Dormir bem", 150)
                ]
                
                let escolhido = viloes.randomElement()!
                
                return Vilao( //seleciona pelo indice do array
                    nome: escolhido.0,
                    tipo: escolhido.1,
                    vida: escolhido.2,
                    ataque: escolhido.3,
                    fraqueza: escolhido.4,
                    recompensaXP: escolhido.5
                )
            }
        }
}
    
// terminei vilao
// comeca sistema do jogo

    struct Caminho {
        let numero:  Int
        let comVilao: Bool
        let dificuldade: Int
        
        func gerarCaminho() -> [Caminho]{
            var caminho: [Caminho] = []
            
            let indiceComVilao = Array (0..<3).shuffled().prefix(2)
            //quero 3 caminhos mas que apenas 2 tenham monstrinhos
            
            for i in 0..<3{
                
                if indiceComVilao.contains(i){
                    //tem vilao
                    let dificuldade = Int.random(in: 1...4)
                    caminho.append(Caminho(numero: i + 1, comVilao: true, dificuldade: dificuldade))
                } else {
                    caminho.append(Caminho(numero: i + 1, comVilao: true, dificuldade: 5))
                    // se der sorte de não ter monstro, vai ser mais facil de abrir
                }
            }
            
            return caminho
        }
    }

class SistemaCombate{
    func iniciarCombate(heroi:Personagem, vilao:Vilao) throws{
        vilao.mostrarInfo()
        
        while heroi.vida > 0 && vilao.vida > 0 {
            print("Sua vez de jogar 🎮")
            print("Pressione ENTER para rolar o dado 🎲")
            readLine()
            
            let dadoHeroi = tipoDado.atributo.rolar()
            print("Você rolou: \(dadoHeroi) 🎲")
            
            // vez do heroi
            if dadoHeroi >= 7 {
                let dano = heroi.atacar()
                print("Voce acertou dano \(dano)")
                vilao.receberDano(dano: dano)
                
                if vilao.vida <= 0 {
                    throw erroJogo.vilaoMorto
                }
            } else {
                print("Oh não! Você falhou no ataque")
            }
            
            //vez do vilão
            if vilao.vida > 0 {
                print("\(vilao) vai te atacaaar 😵")
            }
            
            let dadoVilao = tipoDado.atributo.rolar()
            print("Vilão rolou: \(dadoVilao) 🎲")
            
            if dadoVilao >= 10 {
                let dano = vilao.atacar()
                print("Vilao acertou \(dano)")
                heroi.defender(dano: dano)
                
                if heroi.vida <= 0 {
                    throw erroJogo.personagemMorto
                }
            } else {
                print("Ufaa! Ele falhou no ataque")
            }
            
            if heroi.vida > 0 {
                print("Chegou sua vez de atacaar! ⚔")
            }
        }
    }
    
}

class LabirintoRPG {
    var heroi: Personagem?
    var caminhosPassados = 0
    var caminhosVence = 5
    
    func iniciar(){
        mostrarIntroducao()
        criarPersonagem()
        
        guard let heroi = heroi else {return} //descobri outra forma de "desembrulhar variavel"
        
        while caminhosPassados < caminhosVence && heroi.vida > 0{
            heroi.mostrarStatus()
            enfrentarCaminho()
        }
        if caminhosPassados >= caminhosVence && heroi.vida > 0 {
            mostrarVitoria()
        }
    }
}

func enfrentarCaminho(){
    guard let heroi = heroi else {return}
    
    print("Caminho \(caminhosPassados + 1) de \(caminhosVence)")
    let caminhos = Caminho.gerarCaminho()
    
    print("Voce ve 3 caminhos a sua frente")
    print("Qual caminho voce escolhe")
    
    let entrada = readLine()
    let escolha = Int(entrada)
    escolha > 0

    
    let caminhoEscolhido = caminhos[escolha - 1]
    
    if caminhoEscolhido.comVilao{
        print("Voce vai ter que enfrentar um vilão")
    } else {
        print("")
    }
}

func mostrarIntroducao(){
    print("-------------------------------------------------------------------------------")
    print("Voce acabou de começar a semana, e precisa passar por 5 grandiosos dias, que vão se passar como se fossem portas em que voce pode escolher.")
    print("MAS CUIDADO!!!")
    print("Sempre 2 delas podem ter monstros terriveis, que assombram qualquer um, eles são muito muitoo muitooo assustadores")
    print("-------------------------------------------------------------------------------")
}

func mostrarVitoria(){
    print("-------------------------------------------------------------------------------")
    print("Nós não acreditamos muito em você 😂, brincadeira 😇, mas você provou sua bravarua nessa semana 🏆")
    print("✨✨✨✨✨PARABÉNSSSSS !!!!! VOCE SEXTOUUUUU ✨✨✨✨✨")
    print("-------------------------------------------------------------------------------")
}

func criarPersonagem() {
    print("Para começar a aventura precisamos que voce escolha um personagem")
    print("CLT")
    print("CLT Premuim")
    print("Faria Limier")
    let heroi = readLine()
}

let jogo = LabirintoRPG()
jogo.iniciar()
