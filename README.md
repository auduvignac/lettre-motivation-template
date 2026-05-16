# Lettre de motivation LaTeX template

Package LaTeX minimal pour générer une lettre de motivation française au format A4, avec positionnement précis des blocs expéditeur, destinataire, date, objet, corps, formule de clôture et signature.

Ce repository est destiné à servir de source commune réutilisable, notamment comme `git subtree` dans des repositories de candidatures. L'objectif est de maintenir le gabarit dans une branche `main` propre, puis de propager les évolutions vers les projets consommateurs via des merge requests.

## Contenu

- `lettre_motivation_template.sty` : package LaTeX principal.
- `template_lettre_motivation.tex` : exemple d'utilisation du package.
- `latexmkrc` : configuration de compilation locale avec `latexmk`.
- `template_lettre_motivation.pdf` : rendu d'exemple.

## Utilisation

Dans un document LaTeX :

```tex
\documentclass[a4paper,12pt]{letter}
\usepackage{lettre_motivation_template}

\LMsender
  {Nom Prénom}
  {Numéro de téléphone}
  {Mail}
  {Lieu de résidence}

\LMrecipient
  {Nom de l'entreprise}
  {Responsable, Recruteur, Service}
  {Adresse}

\LMplaceanddate{Ville}{Date}
\LMsetsubject{Candidature : intitulé du poste, type de contrat}
\LMsetgreeting{Madame, Monsieur,}

\LM{%
  Corps de la lettre.
}

\LMsetclosing{%
  Je reste à votre disposition pour un entretien à votre convenance.
}
\LMsetsignature{Nom Prénom}

\begin{document}
\LMmakeletter
\end{document}
```

Compiler l'exemple :

```bash
latexmk
```

Nettoyer les fichiers générés :

```bash
latexmk -c
```

## Options de package

Par défaut, le package garde une configuration prête pour `pdflatex` :

```tex
\usepackage{lettre_motivation_template}
```

Ce mode charge `inputenc` en UTF-8, `fontenc` en T1, `babel` avec `french`, `helvet`, et applique `\sfdefault` comme famille par défaut. `inputenc` et `fontenc` ne sont chargés que sous pdfTeX pour éviter les conflits avec XeLaTeX et LuaLaTeX.

Si le document configure déjà l'encodage, la langue ou les polices, ces choix peuvent être désactivés :

```tex
\usepackage[
  encoding=false,
  fontencoding=false,
  language=false,
  font=false,
  sansdefault=false
]{lettre_motivation_template}
```

Chemin recommandé avec XeLaTeX ou LuaLaTeX :

```tex
\documentclass[a4paper,12pt]{letter}
\usepackage{fontspec}
\usepackage[french]{babel}
\setmainfont{Arial}
\usepackage[
  encoding=false,
  fontencoding=false,
  language=false,
  font=false,
  sansdefault=false
]{lettre_motivation_template}
```

Dans ce cas, compilez le document consommateur avec `xelatex` ou `lualatex`. Le `latexmkrc` de ce repository reste configuré pour l'exemple `pdflatex`.

Les valeurs par défaut peuvent aussi être remplacées sans désactiver tout le chargement :

```tex
\usepackage[
  inputencoding=utf8,
  fontencodingname=T1,
  babeloptions=french,
  fontpackage=helvet
]{lettre_motivation_template}
```

## Personnalisation

Le package expose des longueurs et commandes de mise en page pour ajuster le rendu sans modifier directement le cœur du template :

```tex
\setlength{\LMsenderY}{26.35mm}
\setlength{\LMbodyW}{159.2mm}
\renewcommand{\LMmainfont}{\fontsize{11.25pt}{15.95pt}\selectfont}
```

Les principales zones configurables sont :

- expéditeur : `\LMsenderX`, `\LMsenderY`, `\LMsenderW`
- destinataire : `\LMrecipientX`, `\LMrecipientY`, `\LMrecipientW`
- date : `\LMdateX`, `\LMdateY`, `\LMdateW`
- objet : `\LMsubjectX`, `\LMsubjectY`, `\LMsubjectW`
- formule d'appel : `\LMgreetingX`, `\LMgreetingY`, `\LMgreetingW`
- corps : `\LMbodyX`, `\LMbodyY`, `\LMbodyW`, `\LMbodyParSkip`
- clôture et signature : `\LMclosingSkip`, `\LMsignatureSkip`

## Intégration comme subtree

Depuis un repository de candidature :

```bash
git remote add lettre-motivation-template git@github.com:<owner>/<repo>.git
git subtree add --prefix=vendor/lettre_motivation_template lettre-motivation-template main --squash
```

Mettre à jour le subtree :

```bash
git fetch lettre-motivation-template main
git subtree pull --prefix=vendor/lettre_motivation_template lettre-motivation-template main --squash
```

Proposer une évolution depuis un repository consommateur :

```bash
git subtree push --prefix=vendor/lettre_motivation_template lettre-motivation-template <branche-de-travail>
```

Ouvrir ensuite une merge request depuis `<branche-de-travail>` vers `main` dans le repository du template.

## Workflow de contribution

La branche `main` contient la version stable du template.

Pour une modification :

```bash
git switch main
git pull --ff-only
git switch -c feat/description-courte
```

Après modification :

```bash
latexmk
git status
git add lettre_motivation_template.sty template_lettre_motivation.tex README.md
git commit -m "feat: description courte"
git push -u origin feat/description-courte
```

Créer ensuite une merge request vers `main`.

## Création du repository distant avec GitHub CLI :

Initialisation locale recommandée :

```bash
git init -b main
git add .
git commit -m "chore: initial import"
```

Création du repository distant avec GitHub CLI :

```bash
gh repo create <owner>/<repo> --private --source=. --remote=origin --push
```

Ou, si le repository existe déjà sur GitHub :

```bash
git remote add origin git@github.com:<owner>/<repo>.git
git push -u origin main
```
