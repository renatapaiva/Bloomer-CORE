// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package br.ufpb.dce.bloomer.core.model;

import br.ufpb.dce.bloomer.core.model.Jogo;
import br.ufpb.dce.bloomer.core.model.Questao;
import br.ufpb.dce.bloomer.core.model.Resposta;
import br.ufpb.dce.bloomer.core.model.TipoQuestao;
import java.util.Set;

privileged aspect Questao_Roo_JavaBean {
    
    public String Questao.getPergunta() {
        return this.pergunta;
    }
    
    public void Questao.setPergunta(String pergunta) {
        this.pergunta = pergunta;
    }
    
    public String Questao.getGabarito() {
        return this.gabarito;
    }
    
    public void Questao.setGabarito(String gabarito) {
        this.gabarito = gabarito;
    }
    
    public Jogo Questao.getJogo() {
        return this.jogo;
    }
    
    public void Questao.setJogo(Jogo jogo) {
        this.jogo = jogo;
    }
    
    public TipoQuestao Questao.getTipo() {
        return this.tipo;
    }
    
    public void Questao.setTipo(TipoQuestao tipo) {
        this.tipo = tipo;
    }
    
    public Set<Resposta> Questao.getRespostas() {
        return this.respostas;
    }
    
    public void Questao.setRespostas(Set<Resposta> respostas) {
        this.respostas = respostas;
    }
    
}
