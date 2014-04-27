#!/usr/bin/env ruby
require "./Point"
require './Alphabet.rb'
require './Maillon.rb'
require './TraceConverter'

class Graph

	attr_accessor :g #tete du graphe de résolution

	def initialize
		@g = Graph.buildGraph
	end

	def self.buildGraph
		al = Graph.importJSON
		tab = al.alphabet
		#Construire le graphe depuis les lettres

		tete = Maillon.new(Point.new(-1,-1))
		for i in 0..tab.size-1 #On parcours chaque lettre de l'alphabet
			tmp = tab[i].points#tableau des points d'une lettre
			current = tete #maillon actuel
			for j in 0..tmp.size-1
				m = Maillon.new(Point.new(tmp[j].x, tmp[j].y)) #on créer le maillon associé au point courant
				#current.arcs.each do |a|
				#	if a.m_arr.Equals(m)
				#		m = a.m_arr
				#		break
				#	end
				#end
				if j == tmp.size-1 #dernier point de la lettre
					m.lettre = tab[i].letter #on assigne la lettre au maillon
					current.addArc(Arc.new(current, m,0))
					current = tete #on remet le maillon courant à la tete
				else
					current.addArc(Arc.new(current, m,0))
					current = m
				end
			end
		end
		#renvoi le maillon de tete du graphe construit
		tete
	end

	def solve(tab)
		trace = TraceConverter.new(tab)
		tab_coup = trace.resize
		c = @g.solve(tab_coup)
		puts c
		c
	end

	def self.importJSON 
		fileJson = File.open("alphabet.json", "r")
		txtJson = fileJson.read
		Alphabet.from_json(txtJson)
	end

  	if __FILE__ == $0
  		Graph.buildGraph
  	end
end