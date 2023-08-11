const express = require('express');
const app = express();
const mysql = require('mysql2');
const cors = require('cors');

// Middleware para permitir CORS
app.use(cors());
app.use(express.json());

// Configurações do banco de dados
const base = "id21120487_bd_makarenco";
const db = mysql.createConnection({
  user: "root",
  host: "localhost",
  password: "#Nota1234",
  database: base,
});

// ... (Rotas anteriores)

// Rota para obter notas de provas para uma disciplina específica
app.get("/Notas/Provas/:disciplinaPrefixo", (req, res) => {
  const disciplinaPrefixo = req.params.disciplinaPrefixo;
  db.query("SELECT A.processo, A.nome, P.pp, P.pt, P.mac FROM Aluno A JOIN Prova P ON A.processo = P.aluno_processo JOIN Disciplina D ON P.disciplina_id = D.id WHERE D.prefixo = ?;", [disciplinaPrefixo], (err, result) => {
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
  db.query("SELECT nomeDelegado FROM Turma WHERE id = ?;", [turmaId], (err, result) => {
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
  db.query("SELECT nomeCoordenador FROM Turma WHERE id = ?;", [turmaId], (err, result) => {
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
  db.query("SELECT A.processo, A.nome, SUM(P.pp + P.pt + P.mac) AS total FROM Aluno A JOIN Prova P ON A.processo = P.aluno_processo GROUP BY A.processo ORDER BY total DESC LIMIT 1;", (err, result) => {
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
  db.query("SELECT A.processo, A.nome, SUM(P.pp + P.pt + P.mac) AS total FROM Aluno A JOIN Prova P ON A.processo = P.aluno_processo WHERE A.turma_id = ? GROUP BY A.processo ORDER BY total DESC LIMIT 1;", [turmaId], (err, result) => {
    if (!err) {
      console.log("Consulta do melhor aluno da sala realizada com sucesso");
      res.send(result[0]);
    } else {
      console.error("Consulta não realizada " + err);
      res.status(500).send("Consulta não realizada");
    }
  });
});
// Rota para obter as disciplinas de um curso específico
app.get("/DisciplinasCurso/:cursoId", (req, res) => {
  const cursoId = req.params.cursoId;
  db.query("SELECT D.prefixo, D.nome FROM Disciplina D JOIN CursoDisciplina CD ON D.id = CD.disciplina_id WHERE CD.curso_id = ?;", [cursoId], (err, result) => {
    if (!err) {
      console.log("Consulta das disciplinas do curso realizada com sucesso");
      res.send(result);
    } else {
      console.error("Consulta não realizada " + err);
      res.status(500).send("Consulta não realizada");
    }
  });
});

// ... (Outras rotas)


// Rota para obter o melhor aluno da escola
app.get("/MelhorAlunoEscola", (req, res) => {
  db.query("SELECT A.processo, A.nome, SUM(P.pp + P.pt + P.mac) AS total FROM Aluno A JOIN Prova P ON A.processo = P.aluno_processo GROUP BY A.processo ORDER BY total DESC LIMIT 1;", (err, result) => {
    if (!err) {
      console.log("Consulta do melhor aluno da escola realizada com sucesso");
      res.send(result[0]);
    } else {
      console.error("Consulta não realizada " + err);
      res.status(500).send("Consulta não realizada");
    }
  });
});

// ... (Outras rotas)


// Rota para obter o nome do curso de uma turma
app.get("/Curso/:turmaId", (req, res) => {
  const turmaId = req.params.turmaId;
  db.query("SELECT nomeCurso FROM Turma WHERE id = ?;", [turmaId], (err, result) => {
    if (!err) {
      console.log("Consulta do nome do curso da turma realizada com sucesso");
      res.send(result);
    } else {
      console.error("Consulta não realizada " + err);
      res.status(500).send("Consulta não realizada");
    }
  });
});

// ... (Outras rotas)

// Middleware para lidar com rotas inexistentes
app.use((req, res, next) => {
  res.status(404).send("Página não encontrada");
});

// Inicia o servidor na porta 3001
app.listen(3001, () => {
  console.log("Porta 3001");
  console.log(`Conexão com a base ${base} de dados feita com sucesso`);
});