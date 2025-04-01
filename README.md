# Movie API Flutter Project - Leonardo Pereira Mota

Este é um projeto simples em Flutter que demonstra um pequeno fluxo dentro de um aplicativo, utilizando chamadas de API para exibir informações sobre filmes e adição à lista de 'Para assistir'.

![Image](https://github.com/user-attachments/assets/a9fa8fbd-a724-4289-b2b8-06cd7834f85a)

## Tecnologias
- Flutter
- Dart
- TMDb API
- HTTP para requisições de API
- Provider para reatividade do fluxo do App

## 📂 Arquitetura
O projeto segue uma estrutura organizada para melhor separação de lógica e responsabilidades:
- **Core** → contém arquivos essenciais de monitoramento de estado de carregamento e chamada de API.
- **Models** → representam os dados do aplicativo.
- **Repository** → gerencia as chamadas de API e fornece os dados para a ViewModel.
- **Routes** → gerencia a navegação dentro do app.
- **ViewModel** → gerencia a lógica de estado das telas e controle dos modelos do App.
- **Views** → contém as telas do aplicativo finais apresentadas ao usuário.
- **Widgets** → componentes reutilizáveis da interface usadas nas Views.

## 🔧 Executar
1. Clone este repositório:
   ```sh
   git clone https://github.com/LeonardoMota04/Movie_API_Flutter_Project
   ```
2. Acesse o diretório do projeto:
   ```sh
   cd movie_api_flutter_project
   ```
3. Instale as dependências:
   ```sh
   flutter pub get
   ```
4. Execute o aplicativo:
   ```sh
   flutter run
   ```

## API Key
Este projeto utiliza a API do TMDb. Para rodar corretamente, você precisa de uma chave de API válida. Adicione sua chave no arquivo apropriado:
```dart
const String apiKey = "SUA_CHAVE_AQUI";
```

Este projeto é de código aberto e pode ser usado livremente para aprendizado e experimentação.

leomotadf@gmail.com
www.linkedin.com/in/leonardo-pereira-mota/
