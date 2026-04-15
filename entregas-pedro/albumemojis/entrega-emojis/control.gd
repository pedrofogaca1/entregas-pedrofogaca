
extends Control
# Referências aos nós da cena
@onready var campo = $VBoxContainer/HBoxContainer/LineEdit
@onready var btn_adicionar = $VBoxContainer/HBoxContainer/Button
@onready var btn_limpar = $VBoxContainer/ButtonLimpar
@onready var contador = $VBoxContainer/LabelContador
@onready var lista_container = $VBoxContainer/ListaContainer

# Array que guarda os emojis adicionados
var minha_colecao: Array = []

func _ready() -> void:
	# Conecta os sinais dos botões às funções
	btn_adicionar.pressed.connect(_adicionar_emoji)
	btn_limpar.pressed.connect(_limpar_tudo)

func _adicionar_emoji() -> void:
	var texto = campo.text.strip_edges()

	# Verifica se o campo está vazio
	if texto == "":
		return

	# Verifica se o emoji já foi adicionado
	if texto in minha_colecao:
		contador.text = "⚠️ Esse emoji já está na coleção!"
		return

	# Adiciona ao array e atualiza a tela
	minha_colecao.append(texto)
	campo.text = ""
	_atualizar_lista()

func _limpar_tudo() -> void:
	minha_colecao.clear()
	_atualizar_lista()

func _atualizar_lista() -> void:
	# Remove todos os Labels antigos da lista
	for filho in lista_container.get_children():
		filho.queue_free()

	# Cria um Label novo para cada emoji do array
	for emoji in minha_colecao:
		var novo_label = Label.new()
		novo_label.text = "✨ " + emoji
		lista_container.add_child(novo_label)

	# Atualiza o contador
	contador.text = "Você tem " + str(minha_colecao.size()) + " emoji(s)!"
