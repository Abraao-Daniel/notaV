const express = require('express');
const app = express();
const mysql = require('mysql2');
const cors = require('cors');

// Middleware para permitir CORS
app.use(cors());
app.use(express.json());

// Configuracoes datenv (variaveis de ambiente) by AC 
require('dotenv').config();

// Configurações do banco de dados

const base = process.env.DB_NAME || "id21120487_bd_makarenco";
const db = mysql.createConnection({
  user: process.env.DB_USER || "root",
  host: process.env.DB_HOST || "localhost",
  password: process.env.DB_PASSWORD || "#Nota1234",
  database: base,
});


// Rota para listar todas as áreas de formação
app.get('/areas-formacao', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute('SELECT * FROM tb_area_formacao');
    connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao obter áreas de formação.' });
  }
});

// Rota para listar todos os cursos
app.get('/cursos', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute('SELECT * FROM tb_curso');
    connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao obter cursos.' });
  }
});

// Rota para listar todos os tipos de salas
app.get('/tipos-sala', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute('SELECT * FROM tb_tipo_sala');
    connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao obter tipos de salas.' });
  }
});

// Rota para listar todas as classes
app.get('/classes', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute('SELECT * FROM tb_classe');
    connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao obter classes.' });
  }
});

// Rota para listar todos os alunos
app.get('/alunos', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute('SELECT * FROM tb_aluno');
    connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao obter alunos.' });
  }
});

// Rota para listar todas as disciplinas
app.get('/disciplinas', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute('SELECT * FROM tb_disciplina');
    connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao obter disciplinas.' });
  }
});

// Rota para listar todos os professores
app.get('/professores', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute('SELECT * FROM tb_professor');
    connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao obter professores.' });
  }
});

// Rota para listar todas as horas disponíveis
app.get('/horas', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute('SELECT * FROM tb_hora');
    connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao obter horas disponíveis.' });
  }
});

// Rota para listar todos os períodos de aula
app.get('/periodos', async (req, res) => {
  try {
    const connection = await createConnection();
    const [rows] = await connection.execute('SELECT * FROM tb_periodo');
    connection.end();
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Erro ao obter períodos de aula.' });
  }
});


// Rota para obter notas de provas para uma disciplina específica
app.get("/Notas/Provas/:disciplinaPrefixo", (req, res) => {
  const disciplinaPrefixo = req.params.disciplinaPrefixo;
  db.query("SELECT A.numero_processo, A.nome, N.PP, N.Mac, N.Pt FROM tb_aluno A JOIN tb_notas N ON A.numero_processo = N.numero_processo JOIN tb_disciplina D ON N.cod_disciplina = D.id WHERE D.abreviacao = ?;", [disciplinaPrefixo], (err, result) => {
    if (!err) {
      console.log("Consulta de notas de provas realizada com sucesso");
      res.send(result);
    } else {
      console.error("Consulta não realizada " + err);
      res.status(500).send("Consulta não realizada");
    }
  });
});

// Rota para obter o nome do delegado da turma
app.get("/Delegado/:turmaId", (req, res) => {
  const turmaId = req.params.turmaId;
  db.query("SELECT A.nome FROM tb_aluno A JOIN tb_turma T ON A.numero_processo = T.Cod_Delegado WHERE T.id = ?;", [turmaId], (err, result) => {
    if (!err) {
      console.log("Consulta do nome do delegado da turma realizada com sucesso");
      res.send(result);
    } else {
      console.error("Consulta não realizada " + err);
      res.status(500).send("Consulta não realizada");
    }
  });
});

// Rota para obter o nome do coordenador de turma
app.get("/Coordenador/:turmaId", (req, res) => {
  const turmaId = req.params.turmaId;
  db.query("SELECT P.nome FROM tb_professor P JOIN tb_turma_professor TP ON P.id = TP.cod_professor JOIN tb_turma T ON TP.cod_turma = T.id WHERE T.id = ?;", [turmaId], (err, result) => {
    if (!err) {
      console.log("Consulta do nome do coordenador de turma realizada com sucesso");
      res.send(result);
    } else {
      console.error("Consulta não realizada " + err);
      res.status(500).send("Consulta não realizada");
    }
  });
});

// Rota para obter o melhor aluno do ano
app.get("/MelhorAlunoAno", (req, res) => {
  db.query("SELECT A.numero_processo, A.nome, SUM(N.PP + N.Pt + N.Mac) AS total FROM tb_aluno A JOIN tb_notas N ON A.numero_processo = N.numero_processo GROUP BY A.numero_processo ORDER BY total DESC LIMIT 1;", (err, result) => {
    if (!err) {
      console.log("Consulta do melhor aluno do ano realizada com sucesso");
      res.send(result[0]);
    } else {
      console.error("Consulta não realizada " + err);
      res.status(500).send("Consulta não realizada");
    }
  });
});

// Rota para obter o melhor aluno da sala
app.get("/MelhorAlunoSala/:turmaId", (req, res) => {
  const turmaId = req.params.turmaId;
  db.query("SELECT A.numero_processo, A.nome, SUM(N.PP + N.Pt + N.Mac) AS total FROM tb_aluno A JOIN tb_aluno_turma AT ON A.numero_processo = AT.numero_processo JOIN tb_notas N ON A.numero_processo = N.numero_processo WHERE AT.cod_turma = ? GROUP BY A.numero_processo ORDER BY total DESC LIMIT 1;", [turmaId], (err, result) => {
    if (!err) {
      console.log("Consulta do melhor aluno da sala realizada com sucesso");
      res.send(result[0]);
    } else {
      console.error("Consulta não realizada " + err);
      res.status(500).send("Consulta não realizada");
    }
  });
});

// Inicialização do servidor
const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
