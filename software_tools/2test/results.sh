#!/bin/bash
for f in *.txt
do
input=${f}

#standard arrays
declare -A Teamarr
declare -A Teammat1
declare -A Teammat2
declare -A Goals1
declare -A Goals2
#output arrays
declare -A pts
declare -A Evale
declare -A Efage
############################
let length=0
let lines=0
while IFS= read -r line
do
  IFS=':' read -r -a array <<< "$line"
  #let name=${array[1]}
  temp="${array[0]}"
  temp1="${array[1]}"
  IFS='-' read -r -a array1 <<< "$temp"
  Teamarr[$length]="${array1[0]}"
  let length+=1
  Teamarr[$length]="${array1[1]}"
  let length+=1
  ###################2ndoperation###########3
  IFS=':' read -r -a matrix <<< "$line"
  Teammat[$length]="${matrix[0]}"
  #let name=${array[1]}
  tmp="${matrix[0]}"
  tmp1="${matrix[1]}"
  IFS='-' read -r -a matrix1 <<< "$tmp"
  IFS='-' read -r -a matrix2 <<< "$tmp1"

  Teammat1[$lines]="${matrix1[0]}"
  Goals1[$lines]="${matrix2[0]}"
  Teammat2[$lines]="${matrix1[1]}"
  Goals2[$lines]="${matrix2[1]}"
  let lines+=1
  ############################################
done < "$input"

for ((i=0; i < $length; i++))
do

   uniq[$i]=${Teamarr[$i]}
done
uniq_lth=${#uniq[@]}
for ((i=0; i < $uniq_lth; i++))
do
  let pts[$i]=0
  #echo "TEAM[$i]=${uniq[$i]}"
done

for ((k=0; k < $uniq_lth; k++))
do

  for ((t=0; t < $lines; t++))
  do

    #echo "uniq[$k] = ${uniq[$k]} teammat[$t]=${Teammat1[$t]}"
    un="${uniq[$k]}"
    tm1="${Teammat1[$t]}"
    tm2="${Teammat2[$t]}"
    
    g1="${Goals1[$t]}"
    g2="${Goals2[$t]}"
   
    #echo "un=$un tm1=$tm1 tm2=$tm2 g1=$g1 g2=$g2"
    if [ "$un" == "$tm1" ]; then
      #echo "Vrhke Omada Ghpedouxo"
        
      let Evale[$k]+=$g1
      let Efage[$k]+=$g2
       if [ "$g1" -gt "$g2"  ]; then
         #echo "Nikame"
         let pts[$k]+=3
         #echo "$un $pts[$k]"
       elif  [ "$g1" == "$g2"  ]; then
          let pts[$k]+=1
         #echo "isopalia"
         #echo "$un ${pts[$k]}"
       
        fi


    elif [ "$un" == "$tm2" ]; then
      #echo "Vrhke Omada Filoksenoumenh"
      

      let Efage[$k]+=$g1
      let Evale[$k]+=$g2

         if [ "$g2" -gt "$g1" ]; then
          let pts[$k]+=3
           #echo "Nikame"
         elif  [ "$g1" == "$g2"  ]; then
          let pts[$k]+=1
           #echo "isopalia"
         fi
    fi
  done
     

done

for ((i=0; i < uniq_lth; i++))
do
  Table[$i]=""${uniq[$i]}"  "${pts[$i]}"  "${Evale[$i]}"  "${Efage[$i]}""
done
IFS=$'\n'

sorted=($(sort<<< "${Table[*]}" -k2,2r -k1 | uniq ))
unset IFS
IFS=$'\n'




for ((k=0; k < ${#sorted[@]}; k++))
do
  let z=$k+1
  echo "$z. "${sorted[$k]}""
done
unset IFS

done