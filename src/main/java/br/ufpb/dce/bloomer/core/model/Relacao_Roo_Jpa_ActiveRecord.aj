// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package br.ufpb.dce.bloomer.core.model;

import br.ufpb.dce.bloomer.core.model.Relacao;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Relacao_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager Relacao.entityManager;
    
    public static final EntityManager Relacao.entityManager() {
        EntityManager em = new Relacao().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Relacao.countRelacaos() {
        return entityManager().createQuery("SELECT COUNT(o) FROM Relacao o", Long.class).getSingleResult();
    }
    
    public static List<Relacao> Relacao.findAllRelacaos() {
        return entityManager().createQuery("SELECT o FROM Relacao o", Relacao.class).getResultList();
    }
    
    public static Relacao Relacao.findRelacao(Long id) {
        if (id == null) return null;
        return entityManager().find(Relacao.class, id);
    }
    
    public static List<Relacao> Relacao.findRelacaoEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM Relacao o", Relacao.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void Relacao.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Relacao.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Relacao attached = Relacao.findRelacao(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Relacao.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Relacao.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public Relacao Relacao.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Relacao merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
