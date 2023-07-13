// +-----------------------------------------+
// | Desenvolvedor: WILLIAM / MARCOS         |
// | Atualização:  25/04/2023                |
// | Programa:  PREFEITURA ITAPECERICA       |
// +-----------------------------------------+ 
{---SB 6.0 / BARRA_TP_aviso 1.0 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Max char line 3500} TD_plugin:=0;x:=0; for i := 0 to 99 do begin if substr(RetornaNomeArqEntrada(0),i,1) <> '.' then begin x:= x+1; end else begin break; end; end; x:= x; if substr(RetornaNomeArqEntrada(0),x-1,1) = 'T' then x:= x-1; validaNome := substr(RetornaNomeArqEntrada(0),x-10,10); validaNomeDia := 0; validaNomeMes := 0; validaNomeAno := 0; validaNomeHor := 0; ValidaNomeMin := 0; if (StrTofloat(substr(validaNome,1,2)) > 0) and (StrTofloat(substr(validaNome,1,2)) < 32) then validaNomeDia := 1; if (StrTofloat(substr(validaNome,3,2)) > 0) and (StrTofloat(substr(validaNome,3,2)) < 13) then validaNomeMes := 1; if (StrTofloat(substr(validaNome,5,2)) > 20) and (StrTofloat(substr(validaNome,5,2)) < 30) then validaNomeAno := 1; if (StrTofloat(substr(validaNome,7,2)) >= 0) and (StrTofloat(substr(validaNome,7,2)) < 24) then validaNomeHor := 1; if (StrTofloat(substr(validaNome,9,2)) >= 0) and (StrTofloat(substr(validaNome,9,2)) < 60) then ValidaNomeMin := 1; if (validaNomeDia = 0 ) or (validaNomeMes = 0) or (validaNomeAno = 0) or (validaNomeHor = 0) or (ValidaNomeMin = 0) then abort ('ATENCAO: Nome de arquivo com formatacao INVALIDA! Formatacao correta (DDMMAAHHMM)'); TD_nomeDoArquivo := substr(RetornaNomeArqEntrada(0),1,x); fls_cx:= 0; n_arq:='';{----Pré-Configurações---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}


{---Configurações--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    TD_cliente                    := 'P.M. ITAU DE MINAS - (TRANS)'; //Nome parcialmente completo
    TD_tipoImpresso               := 1;      // 1 = Carnes | 2 = Carta/Boletos |
    TD_qtdPorFolha                := 4;      //Quantidade de impresso por folha
    TD_paginaExtra                := 1;      //Quantidade de paginas nao inclusa no visual (contra-capa/encarte/etc)
    TD_folhasPorCaixa             := 1500;   //Quantidade de Folhar por caixa (carnes = 1500 caixa grande / 500 caixa pequena| Envelope 1000 A4 Caixa grande)
    TD_relatorios                 := 1;      // Desativar Relatorio = 0 | Ativar Relatorios = 1 
    TD_seguranca                  := 0;      // Desativa Barra de segurança = 0 | Ativa Barra de segurança = 1
{---Configurações de segurança-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
    marcaDaguaNome                := 'P.M.I.M'; //Marca dagua prefixo do cliente 
    tamanhoBarraSegurancaRandom   := 98;     //Numero maximo de codigo de segurança gerado com base no tamanhdo da marcadagua+1
    tamanhoBarraSegurancaLooping  := 110;    //Tamanho que da barra
    tamanhomarcaDeSeguranca       := 9999;   //Limite randomico do codigo de segurança

{---Plugin Inicio--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}



{---Plugins Fim-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----Relatorios 4.0-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
If TD_relatorios <> 0 then begin If (TD_relatorios= 1) then begin TD_resumo:= CreateFileLog('Resumo_'+TD_cliente+'_dt'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoResumo:=TD_cliente; WritelnFileLog(TD_resumo,TD_conteudoResumo); TD_registro:= CreateFileLog('Arquivo_Relatorio&Etiqueta_'+TD_cliente+'_'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,4)+'_'+RetornaNomeArqEntrada(0)); TD_conteudoRegistro:='0;'+TD_cliente+';'++';'+FormatDate(SYS_DATE,'DD/MM/AAAA')+';'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_registro,TD_conteudoRegistro); end; If TD_relatorios > 1 then begin    abort('RELATORIO - VALOR INFORMADO INVALIDO'); end; numeroDeCliente:=0; numeroDoLote:=0; end; {VAL.ANT.MRKISI} If TD_tipoImpresso > 2 then begin abort('ATENÇÃO - TIPO DE IMPRESSO INVALIDO'); end; If TD_qtdPorFolha < 1 then begin abort('ATENÇÃO - QUANTIDADE DE IMPRESSO POR FOLHA INVALIDO'); end; If fls_cx > 0 then begin abort('ATENÇÃO - SCRIPT PADRAO INVALIDO, VERSAO DESATUALIZADA INFERIOR A 5.0'); end; If n_arq <>'' then begin abort('ATENÇÃO - SCRIPT BARRA_TP_aviso 1.0 INVALIDO, VERSAO DESATUALIZADA INFERIOR A 2.0'); end; TP_numPage:=1; TP_aviso:=1; TD_idExtra:=''; TD_idCodigoBanco:=''; TD_idNumeroBanco:=''; barraSeg:=''; posicaoBarraSeg:='';
{---Variaveis Global Ini-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
While ReadLn(S) <> EOF do Begin
       {---Variaveis comuns Ini---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
       AVISO          := FormatNumeric(TP_aviso,'000.000'); //Aviso gerado pelo script, convertido p String.
    COD_IMOV       := GetString(S,642,18);
    DIG_IMOV       := GetString(S,6,4);    NUM_ENTR       := GetString(S,545,5);
    COD_BAIXA      := GetString(S,2137,6);    COD_BAIXA2     := GetString(S,2137,6);
    COD_BAIXA3     := GetString(S,2137,6);    COD_PROPR      := GetString(S,26,25);
    PROPRIETARIO   := GetString(S,51,50);     BAIRRO_IMOV    := GetString(S,345,50);
    COMPROMISSARIO := GetString(S,158,50);    CPF            := GetString(S,115,18);
    CEP_IMOVEL     := Getnumeric(S,250,8);    COMPL_IMOV     := GetString(S,265,30);
    LOGRA_IMOV     := GetString(S,295,50);    CID_IMOV       := GetString(S,326,50);
    MATR_IMOV      := GetString(S,642,18);    NUM_IMOVEL     := GetString(S,240,5);
    SETOR          := GetString(S,2072,10);   QUADRA         := GetString(S,2082,10);
    LOTE           := GetString(S,2092,20);   LOGRA_ENTR     := GetString(S,445,50);
    BAIRR_ENTR     := GetString(S,495,50);    COMPL_ENTR     := GetString(S,555,30);
    CEP_ENTREG     := GetNumeric(S,585,8);    CID_ENTREG     := GetString(S,600,40);
    UF_ENTREG      := GetString(S,640,2);    VL_VEN_EDIFIFICA  := GetFloat(S,667,10)/100;
    VL_VEN_TERRENO    := GetFloat(S,677,10)/100;    VL_VEN_IMOVEL     := GetFloat(S,697,10)/100;
    AR_EDIF_UNIFICADA := GetFloat(S,707,10)/100;    AR_EDIF_TOTAL     := GetFloat(S,717,10)/100;
    TOT_LAN_ANUAL     := (GetFloat(S,1177,10) + GetFloat(S,1242,10) + GetFloat(S,1307,10) + GetFloat(S,1372,10) + GetFloat(S,1437,10))/100;
    AREA_TERRENO      := GetFloat(S,727,10)/100;
    FRAC_IDEAL        := GetFloat(S,737,10)/100000;
    ALIQ_TERRENO      := GetFloat(S,757,10)/10000;
    ALIQ_PREDIAL      := GetFloat(S,747,10)/10000;
    VL_MT_TERR        := GetFloat(S,787,10)/100;    TEST_IMOVEL       := GetFloat(S,827,10)/100;
    ZONA_IMOVEL       := GetString(S,837,40);    TIPO_EDIFICACAO   := GetString(S,877,40);
    FRAC_IDEAL        := GetFloat(S,737,10)/100;    DEBITO     := GetString(S,1022,1);
    DES_REC_1  := GetString(S,1127,26);    VL_A_REC_1 := GetFloat(S,1177,10)/100;
    DES_REC_2  := GetString(S,1192,26);    VL_A_REC_2 := GetFloat(S,1242,10)/100;
    DES_REC_3  := GetString(S,1257,26);    VL_A_REC_3 := GetFloat(S,1307,10)/100;
    DES_REC_4  := GetString(S,1322,26);    VL_A_REC_4 := GetFloat(S,1372,10)/100;
    DES_REC_5  := GetString(S,1387,26);    VL_A_REC_5 := GetFloat(S,1437,10)/100; 
    {---Variaveis comuns Fim---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
    {---Configurações Referencia do contribuinte no Registro | Barra de TD_registro 3.0 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
        TD_idArquivo        := GetString(S,2135,12);    //Identificação do arquivo maximo ate 12 numeros
        TD_idNumeroBanco    := GetString(S,2122,10);    //Referencia do Banco
        TD_idCodigoBanco    := GetString(S,2137,6);    //Referencia do contribuinte para com o banco (ex: nossonumero)
        //TD_idExtra          := GetString(S,0,0);   //Identificação extra 
    {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}  
    barraDeControle:=''; ctbs:= '0'; ctbi:= '0'; ctbf:= '0'; ctbn:= '0'; ctb := '99'; if ctb = '99' then begin ctbs := '1'; end; ctb2:=random(999)+1; if ctb2 >= 1 then begin ctbi:='1'; end; ctb3:=IntToFloat(random(999))+1.1; if ctb3 >= 1.1 then begin ctbf:='1'; end; ctb4:=IntToNumeric(random(999))+1.0; if ctb4 >= 1.0 then begin ctbn:='1'; end; barraDeControle:=ctbs+ctbi+ctbf+ctbn+StrNumeric(TD_idArquivo,12); barraDeControle := barraDeControle; TP_numPage:=0; if TD_seguranca = 1 then begin maximoRandom := tamanhoBarraSegurancaRandom; posicaoRandom1 := Random(maximoRandom); if posicaoRandom1 = 0 then begin posicaoRandom1:= 1; end; posicaoRandom2 := Random(maximoRandom); if posicaoRandom2 = 0 then begin posicaoRandom2:= 1; end; posicaoRandom3 := Random(maximoRandom); if posicaoRandom3 = 0 then begin posicaoRandom3:= 1; end; posicaoRandom4 := Random(maximoRandom); if posicaoRandom4 = 0 then begin posicaoRandom4:= 1; end; If (posicaoRandom1 = posicaoRandom2) or (posicaoRandom1 = posicaoRandom3) or (posicaoRandom1 = posicaoRandom4) then begin posicaoRandom1 := posicaoRandom1 + 1; end; If (posicaoRandom2 = posicaoRandom1) or (posicaoRandom2 = posicaoRandom3) or (posicaoRandom2 = posicaoRandom4) then begin posicaoRandom2 := posicaoRandom2 + 1; end; If (posicaoRandom3 = posicaoRandom2) or (posicaoRandom3 = posicaoRandom1) or (posicaoRandom3 = posicaoRandom4) then begin posicaoRandom3 := posicaoRandom3 + 1; end; If (posicaoRandom4 = posicaoRandom2) or (posicaoRandom4 = posicaoRandom1) or (posicaoRandom4 = posicaoRandom3) then begin posicaoRandom4 := posicaoRandom4 + 1; end; marcaDeSeguranca1 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca2 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca3 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); marcaDeSeguranca4 := FormatNumeric(Random(tamanhomarcaDeSeguranca),'0000'); barraSeg := ''; for i := 1 to tamanhoBarraSegurancaLooping do begin if i = posicaoRandom1 then begin composicaoBarraSeg := marcaDeSeguranca1 + ' '; end else begin if i = posicaoRandom2 then begin composicaoBarraSeg := marcaDeSeguranca2 + ' '; end else begin if i = posicaoRandom3 then begin composicaoBarraSeg := marcaDeSeguranca3 + ' '; end else begin if i = posicaoRandom4 then begin composicaoBarraSeg := marcaDeSeguranca4 + ' '; end else begin composicaoBarraSeg := marcaDaguaNome + ' '; end; end; end; end; barraSeg := barraSeg + composicaoBarraSeg; end; posicaoBarraSeg := FormatFloat(posicaoRandom1,'9')+'='+marcaDeSeguranca1+'_'+FormatFloat(posicaoRandom2,'9')+'='+marcaDeSeguranca2+'_'+FormatFloat(posicaoRandom3,'9')+'='+marcaDeSeguranca3+'_'+FormatFloat(posicaoRandom4,'9')+'='+marcaDeSeguranca4; end;
    {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
              //page 1
              BeginPage(PAGE1);
              ClearFields(PAGE1,REC1); 
                  PAGE1.REC1.COD_IMOV   := COD_IMOV;
                  PAGE1.REC1.DIG_IMOV   := DIG_IMOV;
                  PAGE1.REC1.COD_BAIXA  := COD_BAIXA;
                  PAGE1.REC1.COD_BAIXA2 := COD_BAIXA2;
                  PAGE1.REC1.COD_BAIXA3 := COD_BAIXA3;
                  PAGE1.REC1.COD_PROPR  := COD_PROPR;
                  PAGE1.REC1.NOME_PRORP := PROPRIETARIO;
                  PAGE1.REC1.NOME_COMPR := COMPROMISSARIO;
                  PAGE1.REC1.CPF        := CPF;
                  PAGE1.REC1.CEP_IMOVEL := CEP_IMOVEL;
                  PAGE1.REC1.COMPL_IMOV := COMPL_IMOV;
                  PAGE1.REC1.LOGRA_IMOV := LOGRA_IMOV+', '+NUM_IMOVEL;
                  PAGE1.REC1.BAIRR_IMOV := BAIRRO_IMOV;
                  PAGE1.REC1.SETOR      := SETOR;
                  PAGE1.REC1.QUADRA     := QUADRA;
                  PAGE1.REC1.LOTE       := LOTE;
                  PAGE1.REC1.LOGRA_ENTR := LOGRA_ENTR+', '+NUM_ENTR;
                  PAGE1.REC1.BAIRR_ENTR := BAIRR_ENTR;
                  PAGE1.REC1.COMPL_ENTR := COMPL_ENTR;
                  PAGE1.REC1.CEP_ENTREG := CEP_ENTREG;
                  PAGE1.REC1.CID_ENTREG := CID_ENTREG;
                  PAGE1.REC1.UF := UF_ENTREG;
                  PAGE1.REC1.AVS:=AVISO;
                  PAGE1.REC1.N_ARQUIV:=TD_nomeDoArquivo;
              WriteRecord(PAGE1,REC1);
              EndPage(PAGE1);
              TP_numPage:=TP_numPage+1;

              //page Capa
              BeginPage(CAPA);
              ClearFields(CAPA,REC1); 
                  CAPA.REC1.AVS:=AVISO;
                  CAPA.REC1.N_ARQUIV:=TD_nomeDoArquivo;
              WriteRecord(CAPA,REC1);
              EndPage(CAPA);
              TP_numPage:=TP_numPage+1;

              //page 2 aviso
              BeginPage(PAGE2);
              ClearFields(PAGE2,REC1); 
                 PAGE2.REC1.BARRA := barraDeControle;
                 PAGE2.REC1.DEBITO := DEBITO;
                  PAGE2.REC1.AVS:=AVISO;
                  PAGE2.REC1.N_ARQUIV:=TD_nomeDoArquivo;
              WriteRecord(PAGE2,REC1);
              EndPage(PAGE2);
              TP_numPage:=TP_numPage+1;

              //page 3
              BeginPage(PAGE3);
              ClearFields(PAGE3,REC1); 
                  PAGE3.REC1.COD_IMOV   := COD_IMOV;
                  PAGE3.REC1.DIG_IMOV   := DIG_IMOV;
                  PAGE3.REC1.COD_BAIXA  := COD_BAIXA;
                  PAGE3.REC1.COD_BAIXA2 := COD_BAIXA2;
                  PAGE3.REC1.COD_BAIXA3 := COD_BAIXA3;
                  PAGE3.REC1.COD_PROPR  := COD_PROPR;
                  PAGE3.REC1.NOME_PRORP := PROPRIETARIO;
                  PAGE3.REC1.NOM_COMPR  := COMPROMISSARIO;
                  PAGE3.REC1.CEP_IMOVEL := CEP_IMOVEL;
                  PAGE3.REC1.COMPL_IMOV := COMPL_IMOV;
                  PAGE3.REC1.LOGRA_IMOV := LOGRA_IMOV+', '+NUM_IMOVEL;
                  PAGE3.REC1.BAIRR_IMOV := BAIRRO_IMOV;
                  PAGE3.REC1.SETOR      := SETOR;
                  PAGE3.REC1.QUADRA     := QUADRA;
                  PAGE3.REC1.LOTE       := LOTE;
                  PAGE3.REC1.LOGR_ENTRE := LOGRA_ENTR+', '+NUM_ENTR;
                  PAGE3.REC1.BAIRR_ENTR := BAIRR_ENTR;
                  PAGE3.REC1.COMPL_ENTR := COMPL_ENTR;
                  PAGE3.REC1.CEP_ENTREG := CEP_ENTREG;
                  PAGE3.REC1.CID_ENTREG := CID_ENTREG;
                  PAGE3.REC1.UF := UF_ENTREG;
                  PAGE3.REC1.AVS:=AVISO;
                  PAGE3.REC1.N_ARQUIV:=TD_nomeDoArquivo;
              WriteRecord(PAGE3,REC1);
              EndPage(PAGE3);
              TP_numPage:=TP_numPage+1; 

              //page 4
              BeginPage(PAGE4);
              ClearFields(PAGE4,REC1); 
                  PAGE4.REC1.NOM_PROPR  := PROPRIETARIO;
                  PAGE4.REC1.CEP_IMOVEL := CEP_IMOVEL;
                  PAGE4.REC1.COMPL_IMOV := COMPL_IMOV;
                  PAGE4.REC1.LOGRA_IMOV := LOGRA_IMOV;
                  PAGE4.REC1.NUM_IMOVEL := NUM_IMOVEL;
                  PAGE4.REC1.BAIRR_IMOV := BAIRRO_IMOV;
                  PAGE4.REC1.CID_IMOV   := CID_IMOV;
                  PAGE4.REC1.MATR_IMOV  := MATR_IMOV;
                  PAGE4.REC1.SETOR      := SETOR;
                  PAGE4.REC1.QUADRA     := QUADRA;
                  PAGE4.REC1.LOTE       := LOTE;
                  PAGE4.REC1.VL_VEN_EDI := VL_VEN_EDIFIFICA;
                  PAGE4.REC1.VL_VEN_TER := VL_VEN_TERRENO;
                  PAGE4.REC1.VL_VEN_IMO := VL_VEN_IMOVEL;
                  PAGE4.REC1.AR_EDIF_UN := AR_EDIF_UNIFICADA;
                  PAGE4.REC1.AR_EDIF_TO := AR_EDIF_TOTAL;
                  PAGE4.REC1.FRAC_IDEAL := FRAC_IDEAL;
                  PAGE4.REC1.DES_REC_1  := DES_REC_1;
                  PAGE4.REC1.VL_A_REC_1 := VL_A_REC_1;
                  PAGE4.REC1.DES_REC_2  := DES_REC_2;
                  PAGE4.REC1.VL_A_REC_2 := VL_A_REC_2;
                  PAGE4.REC1.DES_REC_3  := DES_REC_3;
                  PAGE4.REC1.VL_A_REC_3 := VL_A_REC_3;
                  PAGE4.REC1.DES_REC_4  := DES_REC_4;
                  PAGE4.REC1.VL_A_REC_4 := VL_A_REC_4;
                  PAGE4.REC1.DES_REC_5  := DES_REC_5;
                  PAGE4.REC1.VL_A_REC_5 := VL_A_REC_5; 
                  PAGE4.REC1.TOT_LAN_AN := TOT_LAN_ANUAL;
                  PAGE4.REC1.AREA_TERR  := AREA_TERRENO;
                  PAGE4.REC1.FRAC_IDEAL := FRAC_IDEAL;
                  PAGE4.REC1.ALIQ_TERR  := ALIQ_TERRENO;
                  PAGE4.REC1.ALIQ_PREDI := ALIQ_PREDIAL;
                  PAGE4.REC1.VL_MT_TERR := VL_MT_TERR;
                  PAGE4.REC1.TEST_IMOV  := TEST_IMOVEL;
                  PAGE4.REC1.ZONA_IMOV  := ZONA_IMOVEL;
                  PAGE4.REC1.TIPO_EDIFC := TIPO_EDIFICACAO;
                  PAGE4.REC1.AVS        := AVISO;
                  PAGE4.REC1.N_ARQUIV   := TD_nomeDoArquivo;
              WriteRecord(PAGE4,REC1);
              EndPage(PAGE4);
              TP_numPage:=TP_numPage+1;

              //page parcelas únicas
              pc:=0;
              for h := 0 to 1 do begin
              BeginPage(PAGE9);
              ClearFields(PAGE9,REC1); 
                  PAGE9.REC1.NOM_PROPR  := PROPRIETARIO;
                  PAGE9.REC1.COD_IMOV   := COD_IMOV;
                  PAGE9.REC1.COD_BAIXA  := COD_BAIXA;
                  PAGE9.REC1.DT_VENC_U0 := GetString(S,2122+(h*868),10);
                  PAGE9.REC1.COD_BARRA  := GetString(S,2155+(h*868),44);
                  PAGE9.REC1.LINHA_DIG  := GetString(S,2199+(h*868),60);
                  pc := pc+1;
                  PAGE9.REC1.PARC       := FormatNumeric(pc,'#####'); 
                  PAGE9.REC1.QR     := GetString(S,2690+(h*868),187);
                  PAGE9.REC1.VLR_LIQUID := GetFloat(S,2340+(h*868),10)/100;
                  PAGE9.REC1.DES_REC_1  := DES_REC_1;
                  PAGE9.REC1.VL_A_REC_1 := GetFloat(S,2540+(h*868),10)/100;
                  PAGE9.REC1.DES_REC_2  := DES_REC_2;
                  PAGE9.REC1.VL_A_REC_2 := GetFloat(S,2550+(h*868),10)/100;
                  PAGE9.REC1.DES_REC_3  := DES_REC_3;
                  PAGE9.REC1.VL_A_REC_3 := GetFloat(S,2560+(h*868),10)/100 ;
                  PAGE9.REC1.DES_REC_4  := DES_REC_4;
                  PAGE9.REC1.VL_A_REC_4 := GetFloat(S,2570+(h*868),10)/100 ;
                  PAGE9.REC1.DES_REC_5  := DES_REC_5;
                  PAGE9.REC1.VL_A_REC_5 := GetFloat(S,2580+(i*868),10)/100 ; 
                  PAGE9.REC1.DIV_VENC   := GetString(S,1022+(h*868),1);
                  PAGE9.REC1.DEBITO     := DEBITO;
                  PAGE9.REC1.AVS        := AVISO;
                  PAGE9.REC1.N_ARQUIV   := TD_nomeDoArquivo;
              WriteRecord(PAGE9,REC1);
              EndPage(PAGE9);
              TP_numPage:=TP_numPage+1;
end;
              //page parcelas
               for i := 0 to 2 do begin       
              BeginPage(PAGE8);
              ClearFields(PAGE8,REC1); 
                    PAGE8.REC1.QR       := GetString(S,5294+(i*868),187);
                  PAGE8.REC1.NOM_PROPR  := PROPRIETARIO;
                  PAGE8.REC1.COD_IMOV   := COD_IMOV;
                  PAGE8.REC1.COD_BAIXA  := GetString(S,4741+(i*868),6);
                  PAGE8.REC1.PARCELA    := GetString(S,4750+(i*868),3);
                  PAGE8.REC1.DT_VENC_PC := GetString(S,4726+(i*868),10);
                  PAGE8.REC1.COD_BARRA  := GetString(S,4759+(i*868),44);
                  PAGE8.REC1.LINHA_DIG  := GetString(S,4803+(i*868),60);
                  PAGE8.REC1.VLR_LIQUID := GetFloat(S,4944+(i*868),10)/100;
                  PAGE8.REC1.DES_REC_1  := DES_REC_1;
                  PAGE8.REC1.VL_A_REC_1 := GetFloat(S,5144+(i*868),10)/100;
                  PAGE8.REC1.DES_REC_2  := DES_REC_2;
                  PAGE8.REC1.VL_A_REC_2 := GetFloat(S,5154+(i*868),10)/100;
                  PAGE8.REC1.DES_REC_3  := DES_REC_3;
                  PAGE8.REC1.VL_A_REC_3 := GetFloat(S,5164+(i*868),10)/100;
                  PAGE8.REC1.DES_REC_4  := DES_REC_4;
                  PAGE8.REC1.VL_A_REC_4 := GetFloat(S,5174+(i*868),10)/100;
                  PAGE8.REC1.DES_REC_5  := DES_REC_5;
                  PAGE8.REC1.VL_A_REC_5 := GetFloat(S,5184+(i*868),10)/100; 
                  PAGE8.REC1.DIV_VENC   := GetString(S,1022,1);
                  PAGE8.REC1.DEBITO     := DEBITO;
                  PAGE8.REC1.AVS        := AVISO;
                  PAGE8.REC1.N_ARQUIV   := TD_nomeDoArquivo; 
              WriteRecord(PAGE8,REC1);
              EndPage(PAGE8);
              TP_numPage:=TP_numPage+1;  
            end;
              {---Relatorio TD_registro CX ID 4.0----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
              If TD_relatorios <> 0 then begin If TD_relatorios = 1 then begin totalNumeroPagina:=0; totalNumeroPagina:=TD_paginaExtra+TP_numPage; quantidadePorLote:= FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPagina))))*TD_qtdPorFolha)*TD_tipoImpresso); if (numeroDeCliente mod quantidadePorLote) = 0 then begin numeroDoLote :=numeroDoLote+1; end; TD_conteudoRegistro:=FormatFloat(numeroDoLote,'9')+';'+barraDeControle+';'+TD_idArquivo+';'+TD_idExtra+';'+FormatNumeric(TP_aviso,'000.000')+';'+TD_idNumeroBanco+';'+TD_idCodigoBanco+';'+posicaoBarraSeg;  WritelnFileLog(TD_registro,TD_conteudoRegistro); numeroDeCliente:=numeroDeCliente+1; TP_aviso:=numeroDeCliente+1; end; end;
              {--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
              MARKUP 
              end;
{---Ordenacaoo por profundidade 6.0  & Relatorio - Resumo Prefeitura-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}
if TP_numPage = 0 then begin abort('NUMERO DE PARCELAS INVALIDO OU NÃO ENCONTRADO!') end else begin totalNumeroPaginaOrdenacao := TD_paginaExtra+TP_numPage; impressoPorCaixa :=0; impressoPorCaixa := FloatToInt((Ceil(((TD_folhasPorCaixa/(totalNumeroPaginaOrdenacao))))*TD_qtdPorFolha)*TD_tipoImpresso);
Convert(TD_qtdPorFolha,true,false,false,impressoPorCaixa,false); end; If TD_relatorios<> 0 then begin if TD_relatorios= 1 then begin If TD_tipoImpresso = 2 then begin impressoFrenteVerso:='(Impresso frente e verso)'; end else begin impressoFrenteVerso:=''; end; TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Geral'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Data e Hora do ODA         '+FormatDate(SYS_DATE,'DD/MM/AAAA')+' '+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),1,2)+':'+SubStr(StrNumeric(FormatTime(SYS_TIME,'HH:MM'),4),3,2); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de paginas:         '+FormatFloat(totalNumeroPaginaOrdenacao,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Impresso p/ fls: '+FormatFloat(TD_qtdPorFolha,'9')+' '+impressoFrenteVerso; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Registro:        '+FormatFloat(numeroDeCliente,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao do Lote'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Caixas:          '+FormatFloat(Ceil(numeroDeCliente/impressoPorCaixa),'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Impressos p/ Caixa:        '+FormatFloat(impressoPorCaixa,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Numero de Fls p/ Caixa:    '+FormatFloat((((totalNumeroPaginaOrdenacao-TD_paginaExtra)*impressoPorCaixa)/TD_qtdPorFolha)/TD_tipoImpresso,'9'); WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:=''; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='- Informacao Extras'; WritelnFileLog(TD_resumo, TD_conteudoResumo); TD_conteudoResumo:='Nome do arquivo:          '+TD_nomeDoArquivo; WritelnFileLog(TD_resumo, TD_conteudoResumo); if TD_idNumeroBanco <> '' then begin TD_conteudoResumo:='Referencia do bando:      '+TD_idNumeroBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if TD_idCodigoBanco <> '' then begin TD_conteudoResumo:='Referencia do Cliente:    '+TD_idCodigoBanco; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; if posicaoBarraSeg <> '' then begin TD_conteudoResumo:='Referencia Barra Segurança:'+posicaoBarraSeg; WritelnFileLog(TD_resumo, TD_conteudoResumo); end; CloseFileLog(TD_resumo); If (TD_relatorios= 1) then begin WritelnFileLog(TD_registro,'*'); CloseFileLog(TD_registro); end; end; end;
{------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------}

