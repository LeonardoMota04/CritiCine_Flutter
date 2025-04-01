/// enum para gerenciar estado de carregamento da API
enum RequestState {
  idle,      // nenhuma requisição sendo feita
  loading,   // carregando os dados
  success,   // sucesso
  error,     // erro
}
