# 🎬 CritiCine - Crítica de filmes em cartaz

CritiCine é um aplicativo autoral desenvolvido em Flutter que permite aos usuários explorarem os filmes que estão em cartaz nos cinemas, visualizarem detalhes, lerem e deixarem comentários em tempo real, além de salvar os filmes que desejam assistir.

A proposta é oferecer uma experiência completa para amantes do cinema, com interface fluida, estado reativo e integração com serviços modernos como Firebase e TMDb API.

![Image](https://github.com/user-attachments/assets/f696d348-51e8-4275-9237-aa59d6d67f57)

## Tecnologias
- Flutter + Dart
- TMDb API 
- Firebase
  - Firebase Authentication (email/senha, Google Sing In)
  - Cloud Firestore (comentários em tempo real)
- Provider 
- HTTP
- Shared Preferences 

## 📂 Arquitetura
O projeto segue uma arquitetura modular e escalável, baseada no padrão MVVM (Model-View-ViewModel) com integrações performáticas do Clean Architecture, com foco na separação de responsabilidades, testabilidade e manutenção facilitada:
```
lib/
├── core/
│   ├── constants/     # Constantes e temas
│   ├── enums/        # Enum de estado de carregamento
├── data/
│   └── repositories/ # Implementações dos repositórios (chamadas externas)
├── domain/
│   ├── models/     # Modelos do domínio
│   └── repository/ # Interfaces dos repositórios
└── presentation/
    ├── views/        # Telas do aplicativo
    ├── viewmodels/   # ViewModels
    ├── routes/       # Rotas de navegação
    └── widgets/      # Widgets reutilizáveis
```

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
