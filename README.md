# UniShop

UniShop é um projeto de e-commerce desenvolvido em Flutter, com arquitetura modular, foco em boas práticas, separação de lógica em controllers e visual moderno.

## Funcionalidades
- **Autenticação**: Login e cadastro de usuários.
- **Home**: Busca, filtro por categoria, ordenação e exibição de produtos.
- **Carrinho**: Adição, remoção e ajuste de quantidade de produtos.
- **Pedidos**: Histórico de pedidos realizados.
- **Conta**: Exibição de dados do usuário e logout.

# App
## Login
![image](https://github.com/user-attachments/assets/0572e5a9-07a5-4d55-84ab-561dc443dcce)
## Cadastro
![image](https://github.com/user-attachments/assets/87aa798a-5e24-4b42-8f16-fa0da5e4c28c)
## Tela de produtos
![image](https://github.com/user-attachments/assets/202e9af9-f4ee-46ab-9146-bce687524c39)
## Carrinho
![image](https://github.com/user-attachments/assets/fee5a1c0-75c5-42e2-ad55-4cfaf0e1f98d)
## Pedidos
![image](https://github.com/user-attachments/assets/fc17fe5f-cf98-48d6-b712-f3ea146c848c)
## Conta
![image](https://github.com/user-attachments/assets/504b5fd4-0599-4f26-88b5-6c0f7895fbb4)

## Estrutura de Pastas

```
lib/
├── core/
│   ├── constants/         # Cores, temas e constantes globais
│   ├── services/          # Serviços utilitários (ex: API)
│   └── utils/             # Funções utilitárias e validações
├── features/
│   ├── account/           # Tela e lógica da conta do usuário
│   ├── auth/              # Login, registro e controller de autenticação
│   ├── cart/              # Carrinho: controller, widgets e página
│   ├── home/              # Home: controller, widgets e página principal
│   └── orders/            # Pedidos: controller, modelos e página
├── models/                # Modelos de dados (Produto, Usuário, Carrinho)
├── repositories/          # Repositórios para acesso a dados/API
├── shared/
│   └── widgets/           # Widgets reutilizáveis (ex: BottomNavBar)
├── main.dart              # Ponto de entrada do app
```

## Responsabilidade dos Principais Arquivos
- **main.dart**: Inicialização do app, injeção de controllers e navegação principal.
- **core/constants/app_colors.dart**: Paleta de cores global.
- **core/services/api_service.dart**: Comunicação com API (mock ou real).
- **features/home/controllers/home_controller.dart**: Lógica de busca, filtro e ordenação de produtos.
- **features/cart/controllers/cart_controller.dart**: Lógica do carrinho (adicionar, remover, decrementar).
- **features/orders/controllers/orders_controller.dart**: Lógica de pedidos (adicionar, listar).
- **features/auth/controllers/auth_controller.dart**: Lógica de autenticação.
- **features/home/pages/home_page.dart**: Tela inicial com busca, filtros e produtos.
- **features/cart/pages/cart_page.dart**: Tela do carrinho, visual moderno com cards.
- **features/orders/pages/orders_page.dart**: Tela de histórico de pedidos.
- **features/account/pages/account_page.dart**: Tela de dados do usuário.
- **shared/widgets/bottom_nav_bar.dart**: Barra de navegação inferior.

## Como rodar o projeto
1. Instale as dependências:
   ```bash
   flutter pub get
   ```
2. Execute o app:
   ```bash
   flutter run
   ```

---
