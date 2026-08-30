import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
              'John Doe',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // CARGO
            const Text(
              'Cargo: Gerente de RH',
              style: TextStyle(fontSize: 16),
            ),

            // SETOR
            const Text(
              'Setor: Recursos Humanos',
              style: TextStyle(fontSize: 16),
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
              context,
              icon: Icons.receipt_long,
              title: 'Contracheque',
              onTap: () {},
            ),

            _buildServiceButton(
              context,
              icon: Icons.support_agent,
              title: 'Abrir chamado para o TI',
              onTap: () {
                // Navega para a tela de gerenciamento de chamados do TI
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChamadosTIScreen()),
                );
              },
            ),

            _buildServiceButton(
              context,
              icon: Icons.nightlight_round,
              title: 'Bônus Noturno',
              onTap: () {},
            ),

            _buildServiceButton(
              context,
              icon: Icons.medical_services,
              title: 'Inserir Atestado Médico',
              onTap: () {},
            ),

            _buildServiceButton(
              context,
              icon: Icons.access_time,
              title: 'Ponto Eletrônico',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
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
          onPressed: onTap,
        ),
      ),
    );
  }
}

// ==========================================
// TELA DE GERENCIAMENTO DE CHAMADOS DE TI
// ==========================================
class ChamadosTIScreen extends StatefulWidget {
  const ChamadosTIScreen({super.key});

  @override
  State<ChamadosTIScreen> createState() => _ChamadosTIScreenState();
}

class _ChamadosTIScreenState extends State<ChamadosTIScreen> {
  final _supabase = Supabase.instance.client;

  // Função para abrir modal de Criar ou Atualizar chamado
  void _mostrarFormularioChamado({Map<String, dynamic>? chamado}) {
    final TextEditingController tipoController =
        TextEditingController(text: chamado != null ? chamado['tipo'] : '');
    final TextEditingController descricaoController = TextEditingController(
        text: chamado != null ? chamado['descricao'] : '');

    // Status padrão para novos chamados ou mantido na edição
    String statusSelecionado = chamado != null ? chamado['status'] : 'Aberto';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            chamado == null ? 'Abrir Chamado para o TI' : 'Atualizar Chamado'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tipoController,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Chamado (ex: Rede, Hardware)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Especifique o problema',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: statusSelecionado,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'Aberto', child: Text('Aberto')),
                  DropdownMenuItem(
                      value: 'Não Resolvido', child: Text('Não Resolvido')),
                  DropdownMenuItem(
                      value: 'Encerrado', child: Text('Encerrado')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    statusSelecionado = value;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final tipo = tipoController.text.trim();
              final descricao = descricaoController.text.trim();

              if (tipo.isNotEmpty && descricao.isNotEmpty) {
                if (chamado == null) {
                  // CREATE: Inserir novo chamado
                  await _supabase.from('chamados').insert({
                    'tipo': tipo,
                    'descricao': descricao,
                    'status': statusSelecionado,
                  });
                } else {
                  // UPDATE: Atualizar chamado existente
                  await _supabase.from('chamados').update({
                    'tipo': tipo,
                    'descricao': descricao,
                    'status': statusSelecionado,
                  }).eq('id', chamado['id']);
                }

                Navigator.pop(context);
              }
            },
            child: Text(chamado == null ? 'Abrir Chamado' : 'Salvar'),
          ),
        ],
      ),
    );
  }

  // Função para Deletar
  void _excluirChamado(int id) async {
    await _supabase.from('chamados').delete().eq('id', id);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chamados de TI'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Abertos'),
              Tab(text: 'Não Resolvidos'),
              Tab(text: 'Encerrados'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildListaChamados('Aberto'),
            _buildListaChamados('Não Resolvido'),
            _buildListaChamados('Encerrado'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _mostrarFormularioChamado(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // Constrói a lista reativa separada por status utilizando StreamBuilder
  Widget _buildListaChamados(String statusFiltro) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _supabase
          .from('chamados')
          .stream(primaryKey: ['id'])
          .eq('status', statusFiltro)
          .order('id', ascending: false),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar: ${snapshot.error}'));
        }

        final chamados = snapshot.data ?? [];

        if (chamados.isEmpty) {
          return Center(
            child: Text('Nenhum chamado com status "$statusFiltro".'),
          );
        }

        return ListView.builder(
          itemCount: chamados.length,
          itemBuilder: (context, index) {
            final chamado = chamados[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                title: Text(
                  chamado['tipo'] ?? 'Sem Título',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(chamado['descricao'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Botão de Atualizar
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () =>
                          _mostrarFormularioChamado(chamado: chamado),
                    ),
                    // Botão de Excluir
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _excluirChamado(chamado['id']),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
