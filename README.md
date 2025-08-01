# Caminho da Mente

Um jogo de tabuleiro 3D em terceira pessoa que explora a jornada da resiliência através de escolhas e consequências.

---

## 🎮 Sobre o Projeto

"Caminho da Mente" é um protótipo de jogo de tabuleiro metafórico desenvolvido em Godot Engine. O jogo coloca o jogador em uma jornada linear de 10 casas, onde cada passo é determinado pela escolha de uma carta. As cartas podem oferecer frases motivacionais (que fazem o jogador avançar) ou desmotivacionais (que o fazem retroceder).

O projeto é uma reflexão sutil sobre a perseverança, inspirada na disciplina do esporte e nos desafios da saúde mental. Ele busca mostrar que, independentemente dos obstáculos, a persistência é a chave para completar a jornada.

## 🚀 Tecnologias Utilizadas

- **Godot Engine:** Versão 4.x
- **Linguagem de Programação:** GDScript

Abra o Godot Engine: Inicie o Godot 4.x.

Importe o projeto: Na tela inicial, clique em "Importar" e selecione a pasta do projeto que você clonou.

Execute a cena principal: Abra a cena main.tscn e clique no botão de "Play" (o ícone de triângulo) para iniciar o jogo.

## 🕹️ Como Jogar
O objetivo é simples: chegar à 10ª casa.

A cada turno, três cartas viradas aparecem na UI.

Clique em uma das cartas para fazer sua escolha.

Se a carta for motivacional (cor azul), você avança uma casa.

Se a carta for desmotivacional (cor vermelha), você retrocede uma casa.

Ao sair do tabuleiro para trás da primeira casa, o jogo termina.

Ao chegar ou passar da 10ª casa, você vence!

## ✨ Recursos de Jogabilidade
Tabuleiro 3D: Um percurso visual de 10 casas.

Sistema de Cartas: Três escolhas aleatórias por turno.

Feedback Visual: A cor das frases e das cartas muda para azul (positivo) ou vermelho (negativo) para reforçar o resultado.

Personagem Animado: A esfera se move suavemente de uma casa para a outra usando Tween.

UI Completa: Contador de progresso, mensagens de status e uma tela de "Game Over" centralizada e colorida.

Câmera em Terceira Pessoa: A câmera acompanha o personagem, proporcionando uma visão envolvente da jornada.

## 📂 Estrutura do Projeto
main.tscn: A cena principal do jogo, contendo toda a hierarquia de nós (personagem, tabuleiro, UI).

Main.gd: O script principal do jogo, responsável por toda a lógica de gameplay, UI e animações.

res/: Pasta de recursos, como ícones, fontes, etc.
