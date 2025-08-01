extends Node3D

# Referências aos nós da cena
var casas = []
var jogador
# UI Original
var label_frase
var botoes = []
var label_contador_casas
# UI de Game Over
var painel_game_over
var label_game_over
var botao_reiniciar_game_over

# Variável de estado do jogo
var posicao_atual = 0

# Cores personalizadas
var cor_motivacional = Color("0a87f1") # Um tom de azul
var cor_desmotivacional = Color("f1300a") # Um tom de vermelho
var cor_normal = Color.WHITE
var cor_fundo_botao_normal = Color("404040")

# Frases motivacionais e desmotivacionais
var frases = {
	"motivacionais": [
		"Acredite em si mesmo! Você avança!",
		"O sucesso é a soma de pequenos esforços. Vá em frente!",
		"Nunca desista dos seus sonhos! Continue a jornada.",
		"Seu esforço está sendo recompensado. Avance mais uma casa!",
		"A persistência leva à vitória. Siga em frente!",
		"Você está no caminho certo. Avance um passo.",
		"Cada passo conta. Dê mais um!",
		"A jornada é longa, mas a recompensa é grande. Continue!",
		"O futuro é construído com cada escolha. Avance com confiança."
	],
	"desmotivacionais": [
		"Não é seu dia de sorte... Volte uma casa.",
		"Talvez não seja a melhor opção. Volte um passo.",
		"A sorte não está do seu lado. Retroceda.",
		"Uma pequena pedra no caminho. Volte um pouco.",
		"O caminho é incerto... Retroceda um passo.",
		"Parece que você está preso. Volte uma casa.",
		"Um obstáculo inesperado. Recue um pouco.",
		"O universo conspira contra você. Volte um passo.",
		"Isso foi um erro de cálculo. Recue uma casa."
	]
}

func _ready():
	# Inicializa as referências aos nós da UI original
	label_frase = $Control/Label
	botoes.append($Control/Button1)
	botoes.append($Control/Button2)
	botoes.append($Control/Button3)
	label_contador_casas = $Control/ContadorCasas
	
	# Inicializa as referências aos nós da UI de Game Over
	painel_game_over = $Control/PainelGameOver
	label_game_over = $Control/PainelGameOver/LabelGameOver
	botao_reiniciar_game_over = $Control/PainelGameOver/BotaoReiniciar
	
	# Esconde o painel de Game Over no início
	painel_game_over.hide()
	
	# Conecta o botão de reinício do painel de Game Over
	botao_reiniciar_game_over.connect("pressed", Callable(self, "_reiniciar_jogo"))
	
	# Inicializa a referência ao nó 3D do jogador
	jogador = $Jogador
	
	# Preenche o array de casas de forma robusta
	for casa in $Tabuleiro.get_children():
		casas.append(casa)
	
	# Conecta os botões das cartas à função de escolha apenas uma vez
	for i in range(botoes.size()):
		botoes[i].connect("pressed", Callable(self, "_on_carta_escolhida").bind(i))

	# Configura o estado inicial do jogo
	_atualizar_posicao_jogador()
	_atualizar_contador_casas()
	_iniciar_rodada()

func _atualizar_posicao_jogador():
	# Verifica o estado do jogo (vitória, derrota ou continua)
	if posicao_atual >= casas.size():
		_jogo_vencido()
	elif posicao_atual < 0:
		_jogo_perdido()
	else:
		# Posição final da animação, com um pequeno offset para o jogador
		var destino = casas[posicao_atual].global_position + Vector3(0, 1.0, 0)
		
		# Cria um novo Tween para animar o movimento do jogador (método Godot 4)
		var tween = create_tween()
		tween.tween_property(
			jogador, 
			"global_position", 
			destino, 
			0.5 # Tempo da animação em segundos
		).set_ease(Tween.EASE_IN_OUT)
	
	_atualizar_contador_casas() # Atualiza o contador após o movimento

func _iniciar_rodada():
	# Mostra a UI original
	label_frase.show()
	label_contador_casas.show()
	for botao in botoes:
		botao.show()
		# Reseta as cores dos botões para o estado normal
		botao.add_theme_color_override("font_color", cor_normal)
		# Se você quiser mudar a cor de fundo dos botões, pode ser feito aqui
		# Exemplo: botao.add_theme_stylebox_override("normal", new_stylebox_flat.set_bg_color(cor_fundo_botao_normal))
		
	label_frase.text = "Escolha uma carta!"
	# Reseta a cor do texto da frase para a cor normal
	label_frase.add_theme_color_override("font_color", cor_normal)
	
	for botao in botoes:
		botao.disabled = false
	
	var carta_motivacional = randi() % 3
	set_meta("carta_motivacional_da_rodada", carta_motivacional)
	
func _on_carta_escolhida(escolha):
	# Desabilita todos os botões para evitar cliques extras
	for botao in botoes:
		botao.disabled = true
	
	label_frase.text = "..." # Efeito visual de suspense
	
	# Espera 1 segundo antes de revelar o resultado
	var timer_revelar = get_tree().create_timer(1.0)
	timer_revelar.timeout.connect(Callable(self, "_revelar_resultado").bind(escolha))

func _revelar_resultado(escolha):
	var carta_motivacional_da_rodada = get_meta("carta_motivacional_da_rodada")
	
	if escolha == carta_motivacional_da_rodada:
		var frase = frases["motivacionais"][randi() % frases["motivacionais"].size()]
		label_frase.text = frase
		posicao_atual += 1
		label_frase.add_theme_color_override("font_color", cor_motivacional) # Muda a cor para azul
		
		# Muda a cor da carta escolhida para azul e as outras para vermelho
		for i in range(botoes.size()):
			if i == escolha:
				botoes[i].add_theme_color_override("font_color", cor_motivacional)
			else:
				botoes[i].add_theme_color_override("font_color", cor_desmotivacional)
	else:
		var frase = frases["desmotivacionais"][randi() % frases["desmotivacionais"].size()]
		label_frase.text = frase
		posicao_atual -= 1
		label_frase.add_theme_color_override("font_color", cor_desmotivacional) # Muda a cor para vermelho
		
		# Muda a cor da carta escolhida para vermelho e as outras para azul
		for i in range(botoes.size()):
			if i == escolha:
				botoes[i].add_theme_color_override("font_color", cor_desmotivacional)
			else:
				botoes[i].add_theme_color_override("font_color", cor_motivacional)
	
	_atualizar_posicao_jogador()
	
	var timer_proxima_rodada = get_tree().create_timer(2.0)
	timer_proxima_rodada.timeout.connect(_iniciar_rodada)

func _jogo_vencido():
	_esconder_ui_original()
	
	painel_game_over.show()
	# OBS: O nó 'PainelGameOver' precisa ser um 'ColorRect' para isso funcionar.
	# A cor do painel de fundo será azul.
	if painel_game_over is ColorRect:
		painel_game_over.color = cor_motivacional
	label_game_over.text = "PARABÉNS, VOCÊ VENCEU!"
	
func _jogo_perdido():
	_esconder_ui_original()
	
	painel_game_over.show()
	# OBS: O nó 'PainelGameOver' precisa ser um 'ColorRect' para isso funcionar.
	# A cor do painel de fundo será vermelha.
	if painel_game_over is ColorRect:
		painel_game_over.color = cor_desmotivacional
	label_game_over.text = "GAME OVER"

func _esconder_ui_original():
	label_frase.hide()
	label_contador_casas.hide()
	for botao in botoes:
		botao.hide()
	
func _reiniciar_jogo():
	painel_game_over.hide()
	
	posicao_atual = 0
	_atualizar_posicao_jogador()
	_iniciar_rodada()
	_atualizar_contador_casas()
	
func _atualizar_contador_casas():
	var casa_atual = posicao_atual + 1
	if casa_atual < 1:
		casa_atual = 1
	label_contador_casas.text = "Casas: " + str(casa_atual) + "/" + str(casas.size())
