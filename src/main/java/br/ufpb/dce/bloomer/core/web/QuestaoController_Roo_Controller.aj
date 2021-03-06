// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package br.ufpb.dce.bloomer.core.web;

import br.ufpb.dce.bloomer.core.model.Jogo;
import br.ufpb.dce.bloomer.core.model.Questao;
import br.ufpb.dce.bloomer.core.model.Resposta;
import br.ufpb.dce.bloomer.core.model.TipoQuestao;
import br.ufpb.dce.bloomer.core.web.QuestaoController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect QuestaoController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String QuestaoController.create(@Valid Questao questao, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, questao);
            return "questaos/create";
        }
        uiModel.asMap().clear();
        questao.persist();
        return "redirect:/questaos/" + encodeUrlPathSegment(questao.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String QuestaoController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Questao());
        return "questaos/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String QuestaoController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("questao", Questao.findQuestao(id));
        uiModel.addAttribute("itemId", id);
        return "questaos/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String QuestaoController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("questaos", Questao.findQuestaoEntries(firstResult, sizeNo));
            float nrOfPages = (float) Questao.countQuestaos() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("questaos", Questao.findAllQuestaos());
        }
        return "questaos/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String QuestaoController.update(@Valid Questao questao, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, questao);
            return "questaos/update";
        }
        uiModel.asMap().clear();
        questao.merge();
        return "redirect:/questaos/" + encodeUrlPathSegment(questao.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String QuestaoController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Questao.findQuestao(id));
        return "questaos/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String QuestaoController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Questao questao = Questao.findQuestao(id);
        questao.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/questaos";
    }
    
    void QuestaoController.populateEditForm(Model uiModel, Questao questao) {
        uiModel.addAttribute("questao", questao);
        uiModel.addAttribute("jogoes", Jogo.findAllJogoes());
        uiModel.addAttribute("respostas", Resposta.findAllRespostas());
        uiModel.addAttribute("tipoquestaos", TipoQuestao.findAllTipoQuestaos());
    }
    
    String QuestaoController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
