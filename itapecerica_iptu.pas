// +-----------------------------------------+
// | Desenvolvedor: WILLIAM / MARCOS         |
// | Atualização:  28/02/2023                |
// | Programa:  PREFEITURA ITAPECERICA       |
// +-----------------------------------------+ 
{---SB 6.0 / BARRA_TP_aviso 1.0 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Max char line 3500} TD_plugin:=0;x:=0; for i := 0 to 99 do begin if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin x:= x+1; end else begin break; end; end; x:= x; if substr(RetornaNomeArqEntrada(0),x-1,1) = 'T' then x:= x-1; validaNome := substr(RetornaNomeArqEntrada(0),x-10,10); validaNomeDia := 0; validaNomeMes := 0; validaNomeAno := 0; validaNomeHor := 0; ValidaNomeMin := 0; if (StrTofloat(substr(validaNome,1,2)) > 0) and (StrTofloat(substr(validaNome,1,2)) < 32) then validaNomeDia := 1; if (StrTofloat(substr(validaNome,3,2)) > 0) and (StrTofloat(substr(validaNome,3,2)) < 13) then validaNomeMes := 1; if (StrTofloat(substr(validaNome,5,2)) > 20) and (StrTofloat(substr(validaNome,5,2)) < 30) then validaNomeAno := 1; if (StrTofloat(substr(validaNome,7,2)) >= 0) and (StrTofloat(substr(validaNome,7,2)) < 24) then validaNomeHor := 1; if (StrTofloat(substr(validaNome,9,2)) >= 0) and (StrTofloat(substr(validaNome,9,2)) < 60) then ValidaNomeMin := 1; if (validaNomeDia = 0 ) or (validaNomeMes = 0) or (validaNomeAno = 0) or (validaNomeHor = 0) or (ValidaNomeMin = 0) then abort ('ATENCAO: Nome de arquivo com formatacao INVALIDA! Formatacao correta (DDMMAAHHMM)'); TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x); fls_cx:= 0; n_arq:='';{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M. ITAPECERICA DA SERRA'; //Nome parcialmente completo
    TD_tipoImpresso               := 1;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 3;      //Quantidade de impresso por folha
    TD_paginaExtra                := 1;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1500;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
    TD_relatorios                 := 0;      // Desativar Relatorio = 0 | Ativar Relatorios = 1 
    TD_seguranca                  := 0;      // Desativa Barra de segurança = 0 | Ativa Barra de segurança = 1
{---Configurações de segurança-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    marcaDaguaNome                := 'P.M.I'; //Marca dagua prefixo do cliente 
    tamanhoBarraSegurancaRandom   := 98;     //Numero maximo de codigo de segurança gerado com base no tamanhdo da marcadagua+1
    tamanhoBarraSegurancaLooping  := 110;    //Tamanho que da barra
    tamanhomarcaDeSeguranca       := 9999;   //Limite randomico do codigo de segurança

{---Plugin Inicio--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}



{---Plugins Fim-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----Relatorios 4.0-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
If TD_relatorios <> 0 then begin If (TD_relatorios= 1) then begin TD_resumo:= CreateFileLog('Resumo_'+TD_cliente+'_dt'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoResumo:=TD_cliente; WritelnFileLog(TD_resumo,TD_conteudoResumo); TD_registro:= CreateFileLog('Arquivo_Relatorio&Etiqueta_'+TD_cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoRegistro:='0;'+TD_cliente+';'++';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_registro,TD_conteudoRegistro); end; If TD_relatorios > 1 then begin    abort('RELATORIO - VALOR INFORMADO INVALIDO'); end; numeroDeCliente:=0; numeroDoLote:=0; end; {VAL.ANT.MRKISI} If TD_tipoImpresso > 2 then begin abort('ATENÇÃO - TIPO DE IMPRESSO INVALIDO'); end; If TD_qtdPorFolha < 1 then begin abort('ATENÇÃO - QUANTIDADE DE IMPRESSO POR FOLHA INVALIDO'); end; If fls_cx > 0 then begin abort('ATENÇÃO - SCRIPT PADRAO INVALIDO, VERSAO DESATUALIZADA INFERIOR A 5.0'); end; If n_arq <>'' then begin abort('ATENÇÃO - SCRIPT BARRA_TP_aviso 1.0 INVALIDO, VERSAO DESATUALIZADA INFERIOR A 2.0'); end; TP_numPage:=1; TP_aviso:=1; TD_idExtra:=''; TD_idCodigoBanco:=''; TD_idNumeroBanco:=''; barraSeg:=''; posicaoBarraSeg:='';
{---Variaveis Global Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
par := 0.0;
While ReadLn(S) <> EOF do Begin
    {---Variaveis comuns Ini---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
    AVISO              := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
    INSCRISCAO         := GetString(S,3360,30);
    AVISO_1            := FormatNumeric(GetNUMERIC(S,48,7),'#######');
    REGISTRO           := Formatnumeric(getnumeric(s,4721,20),'####################');
    INSCRICAO_AUXILIAR := Formatnumeric(getnumeric(s,3300,20),'#########################');
    DECL_IMOB          := TrimStr(GetString(S,4741,30));
    PROPRIETARIO       := GetString(S,70,40);
    CONTRIBU           := GetString(S,120,40);
    CUIDADOS           := GetString(S,4603,100);
    ENDERECO_ENTREGA   := TrimStr(GetString(S,3450,100))+' '+TrimStr(GetString(S,3550,10))+' '+TrimStr(GetString(S,3560,40))+' '+TrimStr(GetString(S,3600,40))+' '+TrimStr(GetString(S,3640,40))+' '+TrimStr(GetString(S,3680,2));
    CEP_ENTREGA        := GetString(S,3682,9);
    END_IMOVEL         := TrimStr(GetString(S,3740,40))+' '+TrimStr(GetString(S,3780,10))+' '+TrimStr(GetString(S,3790,40))+' '+TrimStr(GetString(S,3830,40));
    END_IMOVEL_COMPLT  := TrimStr(GetString(S,160,73))+' CEP: '+TrimStr(GetString(S,233,8));
    tipoSubTipo        := Trimstr(GetString(S,2752,36));
    tipoCorrecao       := '';

    pc := 0; 
    for i := 0 to 20 do begin
        if FloatToInt(StrToFloat(replace(GetString(S,651+(i*125),10),'/',''))) <> 0 then begin
            pc:= pc + 1;
            end else begin
            break;
        end;
    end;
    if pc <> 10 then abort('ERRO: Quantidade de parcelas diferente de 10');
    if TrimStr(GetString(S,4781,1)) <> '' then abort('ERRO: Arquivo deslocado');

    if tipoSubTipo = 'CASA ALINHADA ISOLADA' then begin tipoCorrecao:= '01'; end;
    if tipoSubTipo = 'CASA ALINHADA SUPERPOSTA' then begin tipoCorrecao:= '02'; end;
    if tipoSubTipo = 'CASA RECUADA CONJUGADA' then begin tipoCorrecao:= '03'; end;
    if tipoSubTipo = 'CASA ALINHADA GEMINADA' then begin tipoCorrecao:= '04'; end;
    if tipoSubTipo = 'CASA RECUADA ISOLADA' then begin tipoCorrecao:= '05'; end;
    if tipoSubTipo = 'CASA RECUADA SUPERPOSTA' then begin tipoCorrecao:= '06'; end;
    if tipoSubTipo = 'CASA RECUADA CONJUGADA' then begin tipoCorrecao:= '07'; end;
    if tipoSubTipo = 'CASA RECUADA GEMINADA' then begin tipoCorrecao:= '08'; end;
    if tipoSubTipo = 'APARTAMENTO FRENTE' then begin tipoCorrecao:= '09'; end;
    if tipoSubTipo = 'APARTAMENTO FUNDO' then begin tipoCorrecao:= '10'; end;
    if tipoSubTipo = 'ESCRITORIO SALA ' then begin tipoCorrecao:= '12'; end;
    if tipoSubTipo = 'ESCRITORIO CONJUNTO' then begin tipoCorrecao:= '13'; end;
    if tipoSubTipo = 'COMERCIO COM RESIDENCIA' then begin tipoCorrecao:= '14'; end;
    if tipoSubTipo = 'COMERCIO SEM RESIDENCIA' then begin tipoCorrecao:= '15'; end;
    if tipoSubTipo = 'OUTROS / GALPAO' then begin tipoCorrecao:= '16'; end;
    if tipoSubTipo = 'OUTROS / TELHEIRO  ' then begin tipoCorrecao:= '17'; end;
    if tipoSubTipo = 'OUTROS / INDUSTRIA' then begin tipoCorrecao:= '18'; end;
    if tipoSubTipo = '' then begin tipoCorrecao:= '    '; end;
    if tipoSubTipo = 'OUTORS / ESPECIAL' then begin tipoCorrecao:= '20'; end;


    {---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
    {---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
        TD_idArquivo        := GetString(S,2899,12);    //Identificação do arquivo maximo ate 12 numeros
        TD_idNumeroBanco    := GetString(S,569,4);    //Referencia do Banco
        TD_idCodigoBanco    := GetString(S,591,7);    //Referencia do contribuinte para com o banco (ex: nossonumero)
        //TD_idExtra          := GetString(S,0,0);   //Identificação extra 
    {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
    barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle; TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
    {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    //pagina 01 protocolo entrega
    BeginPage(PAGE1);
    ClearFields(PAGE1,REC1); 
        PAGE1.REC1.AVISO_1 := AVISO_1;
        PAGE1.REC1.INSCR := INSCRISCAO;
        PAGE1.REC1.REGISTRO := REGISTRO;
        PAGE1.REC1.DECL_IMOB := DECL_IMOB;
        PAGE1.REC1.PROPRIET := PROPRIETARIO;
        PAGE1.REC1.CONTRIBU := CONTRIBU;
        PAGE1.REC1.CUIDADOS := CUIDADOS;
        PAGE1.REC1.END_ENTREG := ENDERECO_ENTREGA;
        PAGE1.REC1.CEP_ENTREG := CEP_ENTREGA;
        PAGE1.REC1.CBARRA       := barraDeControle;
        PAGE1.REC1.SBARRA   := barraDeControle;
        PAGE1.REC1.AVS:=AVISO;
        PAGE1.REC1.N_ARQUIV:=TD_nomeDoArquivo;
    WriteRecord(PAGE1,REC1);
    EndPage(PAGE1);
    TP_numPage:=TP_numPage+1;

    {//pagina capa
    BeginPage(PAGE2);
    ClearFields(PAGE2,REC1);
        PAGE2.REC1.AVISO_1 := AVISO_1;
        PAGE2.REC1.INSCR := INSCRISCAO;
        PAGE2.REC1.REGISTRO := REGISTRO;
        PAGE2.REC1.DECL_IMOB := DECL_IMOB;
        PAGE2.REC1.PROPRIET := PROPRIETARIO;
        PAGE2.REC1.CONTRIBU := CONTRIBU;
        PAGE2.REC1.CUIDADOS := CUIDADOS;
        PAGE2.REC1.END_ENTREG := ENDERECO_ENTREGA;
        PAGE2.REC1.CEP_ENTREG := CEP_ENTREGA;
        PAGE2.REC1.AVS:=AVISO;
        PAGE2.REC1.N_ARQUIV:=TD_nomeDoArquivo;
    WriteRecord(PAGE2,REC1);
    EndPage(PAGE2);
    TP_numPage:=TP_numPage+1;}

    // pagina 03 identificação imovel
    BeginPage(PAGE3);
    ClearFields(PAGE3,REC1);
	IF  getstring(s,4771,1) <> ',' THEN BEGIN
        PAGE3.REC1.FRAC_IDEAL := getstring(s,4771,10);
	END ELSE BEGIN	
	    PAGE3.REC1.FRAC_IDEAL := '0,'+getstring(s,4771,10);
	END;	
        PAGE3.REC1.VL_LIXO_AN := getfloat(s,3116,18)+getfloat(s,3050,18);
        PAGE3.REC1.VL_VIAS_AN := getfloat(s,3149,18);
        PAGE3.REC1.VL_ESTR_AN := getfloat(s,3083,18);
        PAGE3.REC1.VL_ANUAL   := getfloat(s,3149,18)+getfloat(s,3116,18)+getfloat(s,3050,18)+getfloat(s,3083,18)+getfloat(s,3721,18);
        PAGE3.REC1.QUADRA     := GetString(S,2838,10);
      //PAGE3.REC1.INSCR_ANTE := GetString(S,3300,25);
        PAGE3.REC1.PARC_SEM   := getstring(s,661,18);   
        PAGE3.REC1.VENAL_TOT  := GetString(S,488,18);
        PAGE3.REC1.LOTEAMENTO := GetString(S,2848,20);
        PAGE3.REC1.INSCR      := INSCRISCAO;
        PAGE3.REC1.DECL_IMOB  := DECL_IMOB;
        PAGE3.REC1.REGISTRO   := REGISTRO;
        PAGE3.REC1.DATA       := SYS_DATE;
        PAGE3.REC1.AVISO_1    := AVISO_1;
        PAGE3.REC1.PROPRIET   := PROPRIETARIO;
        PAGE3.REC1.CONTRIBU   := CONTRIBU;  
        PAGE3.REC1.END_IMOVEL := END_IMOVEL_COMPLT;
        PAGE3.REC1.LOTE       := GetString(S,3410,25);  
        PAGE3.REC1.TIPO_EDIF  := tipoCorrecao;  
        PAGE3.REC1.AREA_CONST := getstring(s,438,14);
        PAGE3.REC1.VL_PRED_AN := getstring(s,3017,18);  
        PAGE3.REC1.VL_PRE_AN  := getfloat(s,3721,18);  
        PAGE3.REC1.AREA_TERR  := getstring(s,387,18); 		
        PAGE3.REC1.VL_TERR_AN := getstring(s,2984,18);
        PAGE3.REC1.VENAL_TERR := getstring(s,402,16);
        PAGE3.REC1.VENAL_CONS := getstring(s,452,16);		
        PAGE3.REC1.VENAL_TOTA := getstring(s,488,16);
        PAGE3.REC1.AVS        := aviso;
        PAGE3.REC1.N_ARQUIV   := TD_nomeDoArquivo;
    WriteRecord(PAGE3,REC1);
    EndPage(PAGE3);
    TP_numPage:=TP_numPage+1;
     
    // pagina 04
    BeginPage(PAGE4);
    ClearFields(PAGE4,REC1);
        PAGE4.REC1.BARRA := barraDeControle;
        PAGE4.REC1.AVS:=AVISO;
        PAGE4.REC1.N_ARQUIV:=TD_nomeDoArquivo;
    WriteRecord(PAGE4,REC1);
    EndPage(PAGE4);
    TP_numPage:=TP_numPage+1;

    // PAGE5    
    BeginPage(PAGE5);
    ClearFields(PAGE5,REC1);
        PAGE5.REC1.AVS:=AVISO;
        PAGE5.REC1.N_ARQUIV:=TD_nomeDoArquivo;
    WriteRecord(PAGE5,REC1);
    EndPage(PAGE5);
    TP_numPage:=TP_numPage+1;

    // PAGE6    
    BeginPage(PAGE6);
    ClearFields(PAGE6,REC1);
        PAGE6.REC1.AVS:=AVISO;
        PAGE6.REC1.N_ARQUIV:=TD_nomeDoArquivo;
    WriteRecord(PAGE6,REC1);
    EndPage(PAGE6);
    TP_numPage:=TP_numPage+1;

    //pagina 07 unica
    BeginPage(PAGE7);
    ClearFields(PAGE7,REC1);
    linha:= SubStr(GetString(S,598,51),1,11) + '-' + SubStr(GetString(S,598,51),12,1) + ' ' + SubStr(GetString(S,598,48),13,11) + '-' + SubStr(GetString(S,598,48),24,1) + ' ' + SubStr(GetString(S,598,48),25,11) + '-' + SubStr(GetString(S,598,48),36,1) + ' ' + SubStr(GetString(S,598,48),37,11) + '-' + SubStr(GetString(S,598,48),48,1);

        {valida valor, data e codigo de barras}
        if FloatToInt(GetFloat(S,536,18)) = 0 then begin abort('Erro: valor UNICA invalido Linha:'+aviso);end;  __vlrbarra := 0; for i := 0 to 43 do Begin if SubStr(GetString(S,554,44),i,1) <> '' then begin  __vlrbarra:= __vlrbarra + FloatToInt(StrToFloat(SubStr(GetString(S,554,44),i,1))); end else begin end; end; if __vlrbarra = 0 then begin abort('Erro Codigo de Barras UNICA Linha:'+aviso);end; if FloatToInt(StrToFloat(replace(GetString(S,526,10),'/',''))) = 0 then begin abort('Erro Vencimento UNICA Linha:'+aviso);end;

        PAGE7.REC1.AVS:=aviso;
        PAGE7.REC1.N_ARQUIV:=TD_nomeDoArquivo;
        PAGE7.REC1.UNICA := 'ÚNICA';
        PAGE7.REC1.DATAUNI := GetDate(S,526,10);
        PAGE7.REC1.DATAUNICA := GetString(S,526,10);
        PAGE7.REC1.VLR_UNI := GetFloat(S,536,18);
        PAGE7.REC1.VLR_UNICA := GetString(S,536,18);
        PAGE7.REC1.REGISTRO := REGISTRO;
        PAGE7.REC1.SACADO := GetString(S,4603,100);
        PAGE7.REC1.INSCR := INSCRISCAO;
        //PAGE7.REC1.COD_FEBRA := GetString(S,67,0);
        //PAGE7.REC1.CAMPOUNIC := GetString(S,41,0);
    PAGE7.REC1.LINHA_DIG := linha;
    PAGE7.REC1.COD_BARRAS := GetString(S,554,44);     
    WriteRecord(PAGE7,REC1);
    EndPage(PAGE7);
    TP_numPage:=TP_numPage+1;

    // pagina 05 parcela 01 até 10

    for i := 0 to pc-1 do begin
    BeginPage(PAGE8);
    ClearFields(PAGE8,REC1);
    linha:= SubStr(GetString(S,723+(i*125),51),1,11) + '-' + SubStr(GetString(S,723+(i*125),51),12,1) + ' ' + SubStr(GetString(S,723+(i*125),48),13,11) + '-' + SubStr(GetString(S,723+(i*125),48),24,1) + ' ' + SubStr(GetString(S,723+(i*125),48),25,11) + '-' + SubStr(GetString(S,723+(i*125),48),36,1) + ' ' + SubStr(GetString(S,723+(i*125),48),37,11) + '-' + SubStr(GetString(S,723+(i*125),48),48,1);
        PAGE8.REC1.AVS:=aviso;
        PAGE8.REC1.N_ARQUIV:=TD_nomeDoArquivo;
        PAGE8.REC1.DATAPARC := GetDate(S,651+(i*125),10);
        PAGE8.REC1.DATAPC := GetString(S,651+(i*125),10);

        {valida valor, data e codigo de barras}
        if FloatToInt(GetFloat(S,661+(i*125),18)) = 0 then begin abort('Erro: valor invalido Linha:'+aviso+' pos:'+FormatFloat(661+(i*125),'9'));end; __vlrbarra := 0;for j := 0 to 43 do Begin  if SubStr(GetString(S,679+(i*125),44),j,1) <> '' then begin  __vlrbarra:= __vlrbarra + FloatToInt(StrToFloat(SubStr(GetString(S,679+(i*125),44),j,1))); end else begin end; end; if __vlrbarra = 0 then begin abort('Erro Codigo de Barras Linha:'+aviso+' pos:'+FormatFloat(679+(i*125),'9'));end; if FloatToInt(StrToFloat(replace(GetString(S,651+(i*125),10),'/',''))) = 0 then begin abort('Erro Vencimento Linha:'+aviso+' pos:'+FormatFloat(651+(i*125),'9'));end;

        PAGE8.REC1.VL_PARC := GetFloat(S,661+(i*125),18);
        PAGE8.REC1.VL_PARCELA := GetString(S,661+(i*125),18);
        PAGE8.REC1.REGISTRO := REGISTRO;
        PAGE8.REC1.SACADO := GetString(S,4603,100);
        PAGE8.REC1.INSCR := INSCRISCAO;
        //PAGE8.REC1.COD_FEBRA := GetString(S,67,0);
        //PAGE8.REC1.CAMPOPARC := GetString(S,43+(i*125),0);
        PAGE8.REC1.PARCELA := Getfloat(S,649+(i*125),2);
        PAGE8.REC1.LINHA_DIG := linha;

        PAGE8.REC1.COD_BARRAS := GetString(S,679+(i*125),44);
    WriteRecord(PAGE8,REC1);
    EndPage(PAGE8);
    TP_numPage:=TP_numPage+1;   
    end;
            
    // pagina 06 atualização de endereço
    BeginPage(PAGE9);
    ClearFields(PAGE9,REC1);
        PAGE9.REC1.AVS:=aviso;
        PAGE9.REC1.N_ARQUIV:=TD_nomeDoArquivo;
       PAGE9.REC1.INSCR := INSCRISCAO;
       PAGE9.REC1.REGISTRO := REGISTRO;
       PAGE9.REC1.QUADRA := GetString(S,2838,10);
       PAGE9.REC1.LOTE := GetString(S,3410,25);
       PAGE9.REC1.END_IMOVEL := END_IMOVEL;
       PAGE9.REC1.PROPRIETAR := PROPRIETARIO;
       PAGE9.REC1.END_ENTREG := ENDERECO_ENTREGA;
    WriteRecord(PAGE9,REC1);
    EndPage(PAGE9);
    TP_numPage:=TP_numPage+1;

    // pagina 10 Telefosnes uteis
    BeginPage(PAGE10);
    ClearFields(PAGE10,REC1);
        PAGE10.REC1.AVS:=aviso;
        PAGE10.REC1.N_ARQUIV:=TD_nomeDoArquivo;
    WriteRecord(PAGE10,REC1);
    EndPage(PAGE10);
    TP_numPage:=TP_numPage+1;
    {---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
        If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;    WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
    {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    MARKUP;
End;
{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
