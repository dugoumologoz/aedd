const btn = document.getElementById("calculo");
const anoNascimento = document.getElementById("data");
const resposta = document.getElementById("resposta");

btn.addEventListener("click", function() {
  if (!anoNascimento.value) {
    resposta.textContent = "Data inválida ou incompleta.";
    return;
  }

  const datdeniversario = new Date(anoNascimento.value);
  const hoje = new Date();
  let age = hoje.getFullYear() - datdeniversario.getFullYear();
  const monthDiff = hoje.getMonth() - datdeniversario.getMonth();
  if (monthDiff < 0 || (monthDiff === 0 && hoje.getDate() < datdeniversario.getDate())) {
    age--;
  }

  resposta.textContent = `Você tem ${age} anos.`;
});
