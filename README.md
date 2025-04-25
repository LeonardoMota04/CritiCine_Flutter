# Movie API Flutter Project

Este é um projeto em Flutter que demonstra um pequeno fluxo de aplicativo voltado para filmes. Ele utiliza integração com a API pública do TMDb para buscar dados reais e oferece funcionalidades como navegação entre telas, gerenciamento de estado, reatividade, tratamento de erros e persistência de dados na sessão. O usuário pode visualizar filmes populares e adicioná-los à sua lista de "Para assistir".

![Image](https://github.com/user-attachments/assets/e3a55e7c-5274-4c3c-8396-f43724bec677)

## Tecnologias
- Flutter + Dart
- TMDb API
- Provider - gerenciamento de estado reativo
- HTTP - consumo de API REST

## 📂 Arquitetura
O projeto segue uma arquitetura modular e escalável, baseada no padrão MVVM (Model-View-ViewModel), com foco na separação de responsabilidades, testabilidade e manutenção facilitada:
- **Core** → contém arquivos essenciais de monitoramento de estado de carregamento, estado de erros de requisição e chamada de API.
- **Models** → representam os dados da API em objetos, integráveis com JSON e mantêm o APP desacoplado da API.
- **Repository** → responsável por intermediar o consumo da API com a ViewModel. Aqui é centralizada toda a lógica de dados externos, como busca de filmes populares ou detalhes de um filme por ID.
- **Routes** → gerencia a navegação dentro do app.
- **ViewModel** → gerencia a lógica de estado das telas. Utiliza o ChangeNotifier para emitir mudanças reativas que atualizam as views automaticamente.
- **Views** → contém as telas do aplicativo finais apresentadas ao usuário. Responsáveis por consumir a lógica da ViewModel e renderizar o layout.
- **Widgets** → componentes reutilizáveis da interface usadas nas Views.

## Reatividade e Estado
O app utiliza Provider para gerenciamento de estado, com ChangeNotifier. Isso permite:
- Atualização automática das views ao adicionar um filme à lista.
- Controle dinâmico do estado de carregamento, com exibição de loaders.
- Reatividade entre diferentes partes do app (como Views e Widgets reutilizáveis).

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
