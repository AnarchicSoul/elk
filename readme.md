# ELK (Elasticsearch, Kibana) Stack avec ECK et Keycloak

![ELK Stack](https://www.elastic.co/guide/en/elastic-stack/current/images/stack-logo.png)

## Table des matières

1. [Introduction](#introduction)
2. [Fonctionnalités](#fonctionnalités)
3. [Prérequis](#prérequis)
4. [Installation](#installation)
5. [Configuration](#configuration)
6. [Utilisation](#utilisation)
7. [Contribuer](#contribuer)
8. [Licence](#licence)
9. [Remerciements](#remerciements)

## Introduction

ELK est un acronyme pour Elasticsearch et Kibana, qui sont des projets open source. Ensemble, ils forment une solution puissante pour la recherche, l'analyse et la visualisation de journaux en temps réel. ECK (Elastic Cloud on Kubernetes) simplifie le déploiement de la stack ELK sur Kubernetes. Ce projet intègre également Keycloak pour l'authentification et l'autorisation.

- **Elasticsearch** : Un moteur de recherche et d'analyse distribué.
- **Kibana** : Une interface utilisateur pour configurer, rechercher et visualiser les données indexées par Elasticsearch.
- **ECK** : Elastic Cloud on Kubernetes, pour déployer et gérer Elasticsearch et Kibana sur Kubernetes.
- **Keycloak** : Un système de gestion des identités et des accès pour ajouter des fonctionnalités d'authentification et d'autorisation.

## Fonctionnalités

- **Recherche et analyse en temps réel** : Elasticsearch offre des capacités de recherche et d'analyse rapides sur des volumes massifs de données.
- **Visualisation** : Kibana permet de créer des tableaux de bord interactifs pour visualiser les données indexées par Elasticsearch.
- **Déploiement simplifié** : ECK permet un déploiement facile sur Kubernetes.
- **Sécurité** : Intégration avec Keycloak pour l'authentification et l'autorisation.

## Prérequis

Avant de commencer, assurez-vous d'avoir les éléments suivants installés sur votre machine :

- **Kubernetes** (version 1.16 ou supérieure)
- **kubectl** (outil en ligne de commande pour Kubernetes)
- **Helm** (outil de gestion de paquets pour Kubernetes)
- **Keycloak** (configuré pour votre environnement)

## Installation

### Cloner le dépôt

```bash
git clone https://github.com/AnarchicSoul/elk.git
cd elk
