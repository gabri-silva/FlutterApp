import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServirCom'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // FOTO DO USUÁRIO
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.white,
                  ),
                ),

                // BOTÃO PARA ALTERAR FOTO
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Funcionalidade será implementada depois
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // NOME
            const Text(
              'Gabriel Almeida',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // CARGO
            const Text(
              'Cargo: Professor',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            // SETOR
            const Text(
              'Setor: Tecnologia da Informação',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Serviços',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // OPÇÕES
            _buildServiceButton(
              icon: Icons.receipt_long,
              title: 'Contracheque',
            ),

            _buildServiceButton(
              icon: Icons.support_agent,
              title: 'Abrir chamado para o TI',
            ),

            _buildServiceButton(
              icon: Icons.nightlight_round,
              title: 'Bônus Noturno',
            ),

            _buildServiceButton(
              icon: Icons.medical_services,
              title: 'Inserir Atestado Médico',
            ),

            _buildServiceButton(
              icon: Icons.access_time,
              title: 'Ponto Eletrônico',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceButton({
    required IconData icon,
    required String title,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            // Funcionalidade será implementada posteriormente
          },
        ),
      ),
    );
  }
}
