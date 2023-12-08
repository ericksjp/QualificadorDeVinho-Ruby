require 'decisiontree'
require 'daru'
require 'graphviz'

data = Daru::DataFrame.from_csv('winequality.csv')

teste = data.to_a

training = []

for value in teste[0] do
  newArray = []
  for att in value do
    newArray.append(att[1])
  end
  training.append(newArray)
end

training.delete_at(0)

rotulos = ['fixed acidity','volatile acidity','citric acid','residual sugar',
          'chlorides','free sulfur dioxide','total sulfur dioxide','density',
          'pH','sulphates','alcohol','quality']

dec_tree = DecisionTree::ID3Tree.new(rotulos, training, 1, :continuous)
dec_tree.train

# vinhos para serem testados
test1 = [15.4,0.59,0.08,4.4,0.086,6.0,29.0,0.9974,3.38,0.5,9.0, 4]
test2 = [7.4,0.7,0.0,1.9,0.076,11.0,34.0,0.9978,3.51,0.56,9.4, 5]
test3 = [11.2,0.28,0.56,1.9,0.075,17.0,60.0,0.998,3.16,0.58,9.8, 6]
test4 = [7.3,0.65,0.0,1.2,0.065,15.0,21.0,0.9946,3.39,0.47,10.0, 7]
test5 = [7.8,0.57,0.09,2.3,0.065,34.0,45.0,0.9941700000000001,3.46,0.74,12.7, 8]

resultado1 = dec_tree.predict(test1)
resultado2 = dec_tree.predict(test2)
resultado3 = dec_tree.predict(test3)
resultado4 = dec_tree.predict(test4)
resultado5 = dec_tree.predict(test5)

puts "Teste vinho 1: Resultado arvore: #{resultado1} ... Resultado correto: #{test1.last}"
puts "Teste vinho 2: Resultado arvore: #{resultado2} ... Resultado correto: #{test2.last}"
puts "Teste vinho 3: Resultado arvore: #{resultado3} ... Resultado correto: #{test3.last}"
puts "Teste vinho 4: Resultado arvore: #{resultado4} ... Resultado correto: #{test4.last}"
puts "Teste vinho 5: Resultado arvore: #{resultado5} ... Resultado correto: #{test5.last}"

dec_tree.graph('/home/erick/Desktop/decisiontree/examples/teste', 'jpg')