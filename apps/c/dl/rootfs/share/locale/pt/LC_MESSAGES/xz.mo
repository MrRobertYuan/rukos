��   ~   0      �        �
     �
  �
      �
  �   �
  7  �  -     F   5     |     �  7   �  �   �  �   �  I   �  �   �  �   Z  H   �     @  �   �  >   ]  9   �  �   �  �   l  �   �  �   s  �   A  �   �     �     �  .   �  6   �     +     >     R     W  !   m  !   �  '   �     �     �       /   8  %   h     �  /   �  ,   �     �  4     $   H     m     �     �     �     �      �           7  :   J  &   �  $   �     �  2   �       $   <  /   a     �     �  3   �  =   �  6   -  d   d      �  O   �  .   :  /   i     �  A   �  .   �  0   %   )   V      �      �      �   ;   �   <   �   8   5!  6   n!     �!     �!  (   �!  I   �!  !   H"  9   j"     �"     �"  0   �"     �"  -   �"  @   &#  8   g#  >   �#  /   �#  7   $  D   G$  &   �$     �$     �$     �$  
   �$  
   �$  
   �$  
   %  
   %  	   %  	   "%  	   ,%  	   6%  	   @%  	   J%  	   T%  "   ^%  *   �%     �%  A   �%  Q   &  *   T&     &  !   �&     �&  �  �&  �   �(  2  �)  :   �-  U   .      ].     ~.  8   �.  �   �.    �/  A   �0  �   �0  �   �1  R   F2  �   �2  �   %3  A   �3  7   34  �   k4  �   5  �   �5  /  !6  �   Q7  �   �7  "   �8     �8  5    9  D   69     {9     �9     �9     �9  /   �9  7   :  6   9:  "   p:  %   �:  #   �:  =   �:  3   ;     O;  ;   j;  7   �;     �;  G   �;  )   A<  (   k<  "   �<     �<     �<     �<  *   =  )   ;=     e=  <   }=  +   �=  .   �=     >  7   4>  ,   l>  7   �>  4   �>     ?     ?  0   4?  C   e?  <   �?  y   �?  *   `@  T   �@  5   �@  6   A  '   MA  D   uA  3   �A  6   �A  2   %B     XB  !   dB     �B  ;   �B  F   �B  ?   %C  C   eC  $   �C     �C  ,   �C  _   D  &   oD  Q   �D  $   �D     E  I   E     \E  }   cE  I   �E  <   +F  J   hF  .   �F  8   �F  O   G  %   kG     �G     �G     �G  
   �G  
   �G  
   �G  
   �G  
   �G  	   �G  	   H  	   H  	   H  	   $H  	   .H  	   8H  -   BH  7   pH     �H  d   �H  W   &I  ;   ~I     �I  &   �I     �I     X          M   L       R   y   g   7       _   n   U   /   @   %   0   #       ,   i   4   E          a      $   O           k   5       |       -   >       ;   z      x   f   u       C      :   2   [   j       v   m       '      e               ]   
   3   D       P   Q       &             .                     d                   J   s         ~   o          q   	       "   Z      l   K   b   t   S   +   T              6   p       W   r   I   <   1   Y   A          )   B   h   (                     ^   F                 \                    9                 }   *                  G   8   w   ?          N   c           {   V   H   =   `       !         �I  �
  �
  J         
   ����J         	   ���� 
  --delta[=OPTS]      Delta filter; valid OPTS (valid values; default):
                        dist=NUM   distance between bytes being subtracted
                                   from each other (1-256; 1) 
  --lzma1[=OPTS]      LZMA1 or LZMA2; OPTS is a comma-separated list of zero or
  --lzma2[=OPTS]      more of the following options (valid values; default):
                        preset=PRE reset options to a preset (0-9[e])
                        dict=NUM   dictionary size (4KiB - 1536MiB; 8MiB)
                        lc=NUM     number of literal context bits (0-4; 3)
                        lp=NUM     number of literal position bits (0-4; 0)
                        pb=NUM     number of position bits (0-4; 2)
                        mode=MODE  compression mode (fast, normal; normal)
                        nice=NUM   nice length of a match (2-273; 64)
                        mf=NAME    match finder (hc3, hc4, bt2, bt3, bt4; bt4)
                        depth=NUM  maximum search depth; 0=automatic (default) 
 Basic file format and compression options:
 
 Custom filter chain for compression (alternative for using presets): 
 Operation modifiers:
 
 Other options:
 
With no FILE, or when FILE is -, read standard input.
       --block-size=SIZE
                      start a new .xz block after every SIZE bytes of input;
                      use this to set the block size for threaded compression       --flush-timeout=TIMEOUT
                      when compressing, if more than TIMEOUT milliseconds has
                      passed since the previous flush and reading more input
                      would block, all pending data is flushed out       --ignore-check  don't verify the integrity check when decompressing       --info-memory   display the total amount of RAM and the currently active
                      memory usage limits, and exit       --no-adjust     if compression settings exceed the memory usage limit,
                      give an error instead of adjusting the settings downwards       --robot         use machine-parsable messages (useful for scripts)       --single-stream decompress only the first stream, and silently
                      ignore possible remaining input data   -0 ... -9           compression preset; default is 6; take compressor *and*
                      decompressor memory usage into account before using 7-9!   -Q, --no-warn       make warnings not affect the exit status   -V, --version       display the version number and exit   -e, --extreme       try to improve compression ratio by using more CPU time;
                      does not affect decompressor memory requirements   -h, --help          display the short help (lists only the basic options)
  -H, --long-help     display this long help and exit   -h, --help          display this short help and exit
  -H, --long-help     display the long help (lists also the advanced options)   -k, --keep          keep (don't delete) input files
  -f, --force         force overwrite of output file and (de)compress links
  -c, --stdout        write to standard output and don't delete input files   -q, --quiet         suppress warnings; specify twice to suppress errors too
  -v, --verbose       be verbose; specify twice for even more verbose   -z, --compress      force compression
  -d, --decompress    force decompression
  -t, --test          test compressed file integrity
  -l, --list          list information about .xz files   Minimum XZ Utils version: %s
  Operation mode:
 %s MiB of memory is required. The limit is %s. %s MiB of memory is required. The limiter is disabled. %s file
 %s files
 %s home page: <%s>
 %s:  %s: Cannot remove: %s %s: Cannot set the file group: %s %s: Cannot set the file owner: %s %s: Cannot set the file permissions: %s %s: Closing the file failed: %s %s: Error reading filenames: %s %s: Error seeking the file: %s %s: File has setuid or setgid bit set, skipping %s: File has sticky bit set, skipping %s: File is empty %s: File seems to have been moved, not removing %s: Filename has an unknown suffix, skipping %s: Filter chain: %s
 %s: Input file has more than one hard link, skipping %s: Invalid argument to --block-list %s: Invalid filename suffix %s: Invalid multiplier suffix %s: Invalid option name %s: Invalid option value %s: Is a directory, skipping %s: Is a symbolic link, skipping %s: Not a regular file, skipping %s: Read error: %s %s: Seeking failed when trying to create a sparse file: %s %s: Too many arguments to --block-list %s: Too small to be a valid .xz file %s: Unexpected end of file %s: Unexpected end of input when reading filenames %s: Unknown file format type %s: Unsupported integrity check type %s: Value is not a non-negative decimal integer %s: Write error: %s %s: poll() failed: %s --list does not support reading from standard input --list works only on .xz files (--format=xz or --format=auto) 0 can only be used as the last element in --block-list Adjusted LZMA%c dictionary size from %s MiB to %s MiB to not exceed the memory usage limit of %s MiB Cannot establish signal handlers Cannot read data from standard input when reading filenames from standard input Compressed data cannot be read from a terminal Compressed data cannot be written to a terminal Compressed data is corrupt Compression and decompression with --robot are not supported yet. Compression support was disabled at build time Decompression support was disabled at build time Decompression will need %s MiB of memory. Disabled Empty filename, skipping Error creating a pipe: %s Error getting the file status flags from standard input: %s Error getting the file status flags from standard output: %s Error restoring the O_APPEND flag to standard output: %s Error restoring the status flags to standard input: %s File format not recognized Internal error (bug) LZMA1 cannot be used with the .xz format Mandatory arguments to long options are mandatory for short options too.
 Maximum number of filters is four Memory usage limit is too low for the given filter setup. Memory usage limit reached No No integrity check; not verifying file integrity None Report bugs to <%s> (in English or Finnish).
 Strms  Blocks   Compressed Uncompressed  Ratio  Check   Filename Switching to single-threaded mode due to --flush-timeout THIS IS A DEVELOPMENT VERSION NOT INTENDED FOR PRODUCTION USE. The .lzma format supports only the LZMA1 filter The environment variable %s contains too many arguments The exact options of the presets may vary between software versions. The sum of lc and lp must not exceed 4 Totals: Unexpected end of input Unknown error Unknown-11 Unknown-12 Unknown-13 Unknown-14 Unknown-15 Unknown-2 Unknown-3 Unknown-5 Unknown-6 Unknown-7 Unknown-8 Unknown-9 Unsupported LZMA1/LZMA2 preset: %s Unsupported filter chain or filter options Unsupported options Unsupported type of integrity check; not verifying file integrity Usage: %s [OPTION]... [FILE]...
Compress or decompress FILEs in the .xz format.

 Using a preset in raw mode is discouraged. Using up to %u threads. Writing to standard output failed Yes Project-Id-Version: xz 5.2.4
Report-Msgid-Bugs-To: xz@tukaani.org
PO-Revision-Date: 2019-09-27 08:08+0100
Last-Translator: Pedro Albuquerque <palbuquerque73@gmail.com>
Language-Team: Portuguese <translation-team-pt@lists.sourceforge.net>
Language: pt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bugs: Report translation errors to the Language-Team address.
Plural-Forms: nplurals=2; plural=(n != 1);
X-Generator: Gtranslator 2.91.7
 
  --delta[=OPÇÕES]    filtro delta; OPÇÕES válidas (valores válidos,
                      predefinição):
                        dist=NÚM   distância entre bytes a serem subtraídos
                                   de cada um (1-256; 1) 
  --lzma1[=OPÇÕES]    LZMA1 ou LZMA2; OPÇÕES é uma lista separada por vírgulas
                      de zero ou mais das opções abaixo (valores válidos,
  --lzma2[=OPÇÕES]    predefinição):
                        preset=PRE repõe as opções para predefinição (0-9[e])
                        dict=NÚM   tamanho do dicionário (4KiB - 1536MiB; 8MiB)
                        lc=NÚM     número de bits de contexto literal (0-4; 3)
                        lp=NÚM     número de bits de posição literal (0-4; 0)
                        pb=NÚM     número de bits de posição (0-4; 2)
                        mode=MODO  modo de compressão (fast, normal; normal)
                        nice=NÚM   tamanho agradável de correspondência (2-273;
                                   64)
                        mf=NOME    localizador de correspondência (hc3, hc4,
                                   bt2, bt3, bt4; bt4)
                        depth=NUM  máximo de profundidade de pesquisa;
                                   0=automatic (predefinição) 
 Opções básicas de formato e compressão de ficheiro:
 
 Cadeia de filtros personalizada para compressão (alternativa às predefinições): 
 Modificadores de operações:
 
 Outras opções:
 
Sem FICH, ou quando FICH é -, lê da entrada padrão.
       --block-size=TAM
                      inicia novo bloco .xz após cada TAM bytes de entrada;
                      use para definir o tamanho de bloco para compressão com
                      linhas       --flush-timeout=EXPIRA
                      ao comprimir, se mais de EXPIRA milissegundos tiverem
                      passado desde o despejo anterior e ler mais dados da
                      entrada bloquearia, todos os dados pendentes serão
                      despejados       --ignore-check  não verifica a integridade ao descomprimir       --info-memory   mostra a quantidade total de RAM e os limites de uso
                      de memória actualmente activos e sai       --no-adjust     se as configurações de compressão excederem o limite de
                      uso de memória, devolve um erro em vez de reduzir as
                      configurações       --robot         usa mensagens analisáveis por máquina (útil para scripts)       --single-stream descomprime só o primeiro fluxo e ignora silenciosamente
                      possíveis dados de entrada restantes   -0 ... -9           predefinição de compressão; a predefinição é 6; tenha em
                      conta o uso de memória do compressor *e* descompressor
                      antes de usar 7-9!   -Q, --no-warn       fazer avisos não afecta o estado da saída   -V, --version       mostra o número da versão e sai   -e, --extreme       tenta melhorar o rácio de compressão usando mais tempo de
                      CPU; não afecta os requisitos de memória do descompressor   -h, --help          mostra a ajuda curta (lista só as opções básicas)
  -H, --long-help     mostra esta mensagem de ajuda e sai   -h, --help          mostra esta mensagem de ajuda e sai
  -H, --long-help     mostra a ajuda longa (lista também as opções avançadas)   -k, --keep          mantém (não elimina) os ficheiros de entrada
  -f, --force         força a sobreposição do ficheiro de saída e a 
                      (des)compressão de ligações
  -c, --stdout        escreve na saída padrão e não elimina os ficheiros de
                      entrada   -q, --quiet         suprime avisos, use duas vezes para suprimir também erros
  -v, --verbose       é verboso; use duas vezes para ainda mais verbosidade   -z, --compress      força a compressão
  -d, --decompress    força a descompressão
  -t, --test          testa a integridade do ficheiro comprimido
  -l, --list          lista informações sobre ficheiros .xz   Versão mínima do XZ Utils: %s
  Modo de operação:
 São necessários %s MiB de memória. O limite é %s. São necessários %s MiB de memória. O limitador está desactivado. %s ficheiro
 %s ficheiros
 Página inicial %s: <%s>
 %s:  %s: impossível remover: %s %s: impossível definir o grupo do ficheiro: %s %s: impossível definir o proprietário do ficheiro: %s %s: impossível definir as permissões do ficheiro: %s %s: falha ao fechar o ficheiro: %s %s: erro ao ler nomes de ficheiro: %s %s: erro ao procurar o ficheiro: %s %s: o ficheiro tem o bit setuid ou setgid definido, a ignorar %s: o ficheiro tem o bit sticky definido, a ignorar %s: o ficheiro está vazio %s: o ficheiro parece ter sido movido, não será eliminado %s: nome de ficheiro com sufixo desconhecido, a ignorar %s: cadeia de filtros: %s
 %s: o ficheiro de entrada tem mais de uma ligação absoluta, a ignorar %s: argumento inválido para --block-list %s: sufixo de nome de ficheiro inválido %s: sufixo multiplicador inválido %s: nome de opção inválido %s: valor de opção inválido %s: é uma pasta, a ignorar %s: é uma ligação simbólica, a ignorar %s: não é um ficheiro normal, a ignorar %s: erro de leitura: %s %s: falha na procura ao tentar criar um ficheiro escasso: %s %s: demasiados argumentos para --block-list %s: muito pequeno para um ficheiro .xz válido %s: fim de ficheiro inesperado %s: fim de entrada inesperado ao ler nomes de ficheiros %s: tipo de formato de ficheiro desconhecido %s: tipo de verificação de integridade não suportado %s: o valor não é um inteiro decimal não-negativo %s: erro de escrita: %s %s: poll() falhou: %s --list não suporta a leitura da entrada padrão --list só funciona em ficheiros .xz (--format=xz ou --format=auto) 0 só pode ser usado como o último elemento em --block-list Ajustado o tamanho de dicionário de LZMA%c de %s MiB para %s MiB para não exceder o limite de uso de memória de %s MiB Impossível estabelecer gestores de sinais Impossível ler dados da entrada padrão ao ler nomes de ficheiro da entrada padrão Dados comprimidos não podem ser lidos de um terminal Dados comprimidos não podem ser escritos num terminal Os dados comprimidos estão corrompidos Compressão e descompressão com --robot ainda não são suportadas. O suporte a compressão foi desactivado ao compilar O suporte a descompressão foi desactivado ao compilar A descompressão precisará de %s MiB de memória. Desactivado Nome de ficheiro vazio, a ignorar Erro ao criar um túnel: %s Erro ao obter as bandeiras de estado da entrada padrão: %s Erro ao obter as bandeiras de estado do ficheiro da saída padrão: %s Erro ao restaurar a bandeira O_APPEND para a saída padrão: %s Erro ao restaurar as bandeiras de estado para a entrada padrão: %s Formato de ficheiro não reconhecido Erro interno (erro) Impossível utilizar LZMA1 com o formato .xz Argumentos obrigatórios para opções longas são também obrigatórios para
opções curtas.
 O número máximo de filtros é quatro O limite de uso de memória é baixo demais para a configuração de filtro dada. Limite de uso de memória alcançado Não Sem teste de integridade; a integridade do ficheiro não será verificada Nenhum Reporte erros em <%s> (em inglês ou finlandês).
Relate erros de tradução em <translation-team-pt@lists.sourceforge.net>.
 Fluxos Blocos   Comprimido Descomprimido Rácio  Verif.  Nome de ficheiro A mudar para o modo de linha única devido a --flush-timeout ESTA É UMA VERSÃO DE DESENVOLVIMENTO NÃO DESTINADA A USO EM PRODUÇÃO. O formato .lzma tem só suporta o filtro LZMA1 A variável de ambiente %s contém demasiados argumentos As opções exactas de predefinições podem variar entre versões do programa. A soma de lc e lp não deve exceder 4 Totais: Fim de entrada inesperado Erro desconhecido SemNome-11 SemNome-12 SemNome-13 SemNome-14 SemNome-15 SemNome-2 SemNome-3 SemNome-5 SemNome-6 SemNome-7 SemNome-8 SemNome-9 Predefinição LZMA1/LZMA2 não suportada: %s Opções de filtro ou cadeia de filtros não suportadas Opções não suportadas Tipo de verificação de integridade não suportada; a integridade do ficheiro não será verificada Uso: %s [OPÇÕES]... [FICHEIRO]...
Comprime ou descomprime FICHEIROs no formato .xz.

 O uso de uma predefinição em modo bruto é desencorajado. A usar até %u linhas. A escrita para a saída padrão falhou Sim PRIu32 Using up to % threads. A usar até % linhas. 