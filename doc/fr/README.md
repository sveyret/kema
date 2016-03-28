# kema, le gestionnaire de noyau pour Gentoo

kema est un ensemble de scripts utilisé pour faciliter la gestion de noyau Linux dans Gentoo. Ses principaux objectifs sont :
* mise à jour rapide du noyau lorsqu'une nouvelle version est lirée ;
* tests de configuration sur un noyau ;
* conservation systématique d'un noyau de secours, pour le cas où une mise à jour ou un test ne fonctionne pas comme prévu.

# Langue

Le français étant ma langue maternel, fournir les documents et messages en français n'est pas une option. Les autres traductions sont bienvenues.

Cependant, l'anglais étant la langue de la programmation, le code, y compris les noms de variable et commentaires, sont en anglais.

# Licence

Copyright © 2016 Stéphane Veyret stephane_POINT_veyret_CHEZ_neptura_POINT_org

kema est un outil libre ; vous pouvez le redistribuer ou le modifier suivant les termes de la GNU General Public License telle que publiée par la Free Software Foundation ; soit la version 3 de la licence, soit (à votre gré) toute version ultérieure.

kema est distribué dans l'espoir qu'il sera utile, mais SANS AUCUNE GARANTIE ; pas même la garantie implicite de COMMERCIALISABILITÉ ni d'ADÉQUATION à UN OBJECTIF PARTICULIER. Consultez la GNU General Public License pour plus de détails.

Vous devez avoir reçu une copie de la GNU General Public License en même temps que kema ; si ce n'est pas le cas, consultez http://www.gnu.org/licenses.

# Installation

Un Makefile est fourni pour compiler les messages. L'installation se fait simplement en copiant les fichiers aux emplacements appropriés.

    DEST=/
    LINGUAS=fr
    make
    cp -R usr etc ${DEST}
    cp po/${LINGUAS}.mo /usr/share/locale/${LINGUAS}/LC_MESSAGES/kema.mo
    mkdir -p /var/lib/kema

Il est également conseillé d'installer le paquet _genkernel_ si vous en avez besoin pour créer un _initramfs_.

# Mode d'emploi

Avant d'utiliser kema, vérifiez que le fichier de configuration /etc/kema/kema.conf correspond à vos besoins. Le fichier de configuration par défaut contient des commentaires explicatifs pour chaque option.

## Mise à jour

Lorsque vous mettez votre noyau à jour pour la première fois, vous pouvez avoir besoin de spécifier la version du noyau que vous voulez utiliser :

    kema upgrade 4.1.15

Cela sera également le cas s'il y a plusieurs noyaux possibles dans le répertoire /usr/src. Si vous utilisez kema à chaque fois que les sources d'un nouveau noyau est installé sur votre ordinateur, la nouvelle version devrait être détectée automatiquement. Vous pourrez donc simplement faire :

    kema upgrade

Le noyau actuel sera conservé comme noyau de secours et votre gestionnaire d'amorçage sera modifié pour le sélectionner en cas de besoin.

La mise à jour du noyau ouvre le menu de configuration de noyau. Si vous ne souhaitez pas y faire de modification, vous pouvez simplement sortir. La configuration du noyau précédent sera automatiquement importée.

Si vous laissez _genkernel_ créer le fichier d'_initramfs_, celui-ci devra être intégré au noyau. Vous devrez donc veiller à laisser l'option de configuration noyau _CONFIG_INITRAMFS_SOURCE_ à _initramfs.cpio_. Il en est de même si vous fournissez un fichier d'_initramfs_ a intégrer.

Vous pouvez également spécifier une option _initramfs_ à faire ajouter au noyau par le gestionnaire d'amorçage. Dans ce cas, il est de votre responsabilité d'installer ce fichier au bon endroit.

## Test

Si vous souhaitez tester des modifications d'options sur le noyau courant, vous pouvez exécuter :

    kema test

Cela ouvrira le menu de configuration de noyau. Une fois que les modifications sont faites, quittez le menu. Cela créera un nouveau noyau avec les options sélectionnées. Les options du noyau courant seront sauvegardées. Si les tests réussissent, terminez avec la commande :

    kema valid

Cela remplacera le noyau par défaut avec le noyau testé. Si vos tests échouent, vous pouvez les annuler par la commande :

    kema cancel

Cela remettra le noyau par défaut en place et supprimera les modifications testées.

## Autres fonctionnalités

Afin d'avoir des informations sur l'état courant (noyaux installés, test en cours) il est possible d'utiliser la commande :

    kema status

# Tâches

## Version 0.9

- [x] Ajouter un kema status pour voir si l'on est en cours de test.
- [x] Analyser les variables du fichier de configuration, les préfixer avec KEMA_, et donner des valeurs par défaut. Commenter le fichier de configuration.
- [ ] Ajouter la gestion des options de noyau et initrd.
- [x] Ajouter le gestionnaire d'amorçage efi.

## Version 1.0

- [ ] Ajouter un message pour chaque noyau supprimé.
- [ ] Ne pas supprimer les noyau présents dans eselect (non désinstallés), mais afficher un avertissement.
- [ ] Prendre en compte les code de retour des commandes et arrêter le programme en cas d'erreur.

## Future version

- [ ] Ajouter d'autres gestionnaires d'amorçage.
- [ ] Ajouter d'autres traductions.

