#!/bin/bash
for f in *.txt
do
input=${f}
#arrays
declare -A Xarr
declare -A Yarr
let length=0
#############################
#final parameters declaration
let sum_x=0
let sum_x2=0
let sum_y=0
let sum_xy=0
let err=0
let a=0
let b=0
let c=1
let flag=0
let x1=0
let x2=0
let p=0
#############################
while IFS= read -r line
do
  IFS=':' read -r -a array <<< "$line"
  Xarr[$length]=${array[0]}
  Yarr[$length]=${array[1]}
  let length+=1
done < "$input"
for ((k=0; k < ($length-1); k++))
do
  let x1=$((Xarr[$k]))
  let x2=$((Xarr[($k+1)]))
  if [  "$x1" -ne "$x2" ];
   then  
    let flag=1
  fi
done
if [  "$flag" -eq 0 ];  
 then
    echo "diairesh me 0"
else
  for ((i=0; i < $length; i++))
  do
  sum_x=$(echo "scale=2; ${Xarr[$i]}+$sum_x" | bc)
  sum_y=$(echo "scale=2; ${Yarr[$i]}+$sum_y" | bc)
  sum_xy=$(echo "scale=2; (${Yarr[$i]}*${Xarr[$i]})+$sum_xy" | bc)
  sum_x2=$(echo "scale=2; (${Xarr[$i]}*${Xarr[$i]})+$sum_x2" | bc)
  done
  a=$(echo "scale=2; ($length*$sum_xy-$sum_x*$sum_y)/($length*$sum_x2-$sum_x*$sum_x)" | bc)
  b=$(echo "scale=2; ($sum_y-$a*$sum_x)/$length" | bc)
  for ((i=0; i < $length; i++))
  do
    err=$(echo "scale=2; ((${Yarr[$i]}-($a*${Xarr[$i]}+$b))^2+$err)" | bc)
  done
  echo "FILE: input$f, a=$a b=$b c=$c err=$err"
  
fi
done
