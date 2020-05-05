#!/usr/bin/env bash
quality="70"            #图片质量
RESOLUTION="50%x50%"    #图片压缩率
watermark=""            #图片水印
#设置不同的flag来判断参数是否被使用开启
Q_FLAG="0"   
R_FLAG="0"
W_FLAG="0"
C_FLAG="0"
H_FLAG="0"
PREFIX=""
POSTFIX=""
DIR=$(pwd)              #要操作的图片目录

#输出帮助信息
helps()   
{
	echo "Use:bash img.sh  -d <directory> [option|option]"
	
	echo "options:"
	echo "  -d [directory]                   Path to pending file"
	echo "  -c                               png/svg -> jpg"
	echo "  -r|--resize [width*height|width] Keep original aspect ratio for compression"
	echo "  -q|--quality [number]            Quality compression of jpg images"
	echo "  -w|--watermark [watermark]       Add watermark"
	echo "  --prefix[prefix]                 Add prefix"
	echo "  --postfix[postfix]               Add suffix"
}

main()
{
#输出帮助信息
if [[ "$H_FLAG" == "1" ]]; then
  helps
fi
#-d dir 如果是文件夹返回true
if [ ! -d "$DIR" ] ; then
  echo "No such directory"
  exit 0
fi

#新建一个output文件夹用来保存输出文件
output=${DIR}/output
mkdir -p "$output"

#拼凑出需要执行的指令
command="convert"
IM_FLAG="2"
#对jpeg格式图片进行图片质量压缩
if [[ "$Q_FLAG" == "1" ]]; then
  IM_FLAG="1"
  command=${command}" -quality "${quality}
fi
#对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
if [[ "$R_FLAG" == "1" ]]; then
  command=${command}" -resize "${RESOLUTION}
fi
#添加自定义文本水印
if [[ "$W_FLAG" == "1" ]]; then
  echo ${watermark}
  command=${command}" -fill white -pointsize 40 -draw 'text 10,50 \"${watermark}\"' "
fi

#将png/svg图片统一转换为jpg格式
if [[ "$C_FLAG" == "1" ]]; then
  IM_FLAG="2"
fi

#根据需要获取对应后缀的图片
case "$IM_FLAG" in
	1) images="$(find "$DIR" -maxdepth 1 -regex '.*\(jpg\|jpeg\)')" ;;
	2) images="$(find "$DIR" -maxdepth 1 -regex '.*\(jpg\|jpeg\|png\|svg\)')" ;;
esac 

#根据指令处理每一个文件
for CURRENT_IMAGE in $images; do
     filename=$(basename "$CURRENT_IMAGE")  #只取出文件名
     name=${filename%.*}                    #去掉后缀
     suffix=${filename#*.}                  #取出后缀
     if [[ "$suffix" == "png" && "$C_FLAG" == "1" ]]; then 
       suffix="jpg"
     fi
     if [[ "$suffix" == "svg" && "$C_FLAG" == "1" ]]; then
       suffix="jpg"
     fi
     savefile=${output}/${PREFIX}${name}${POSTFIX}.${suffix}  #重新拼出一个存储路径
     temp="${command} ${CURRENT_IMAGE} ${savefile}"  #指令 需要执行操作的图片路径  图片操作后存储路径
     
     #运行拼凑出来的指令
     eval "$temp"     
     #echo $temp
done

exit 0

}

#  $@指代命令行上的所有参数
# -o 后面接短参数  没有冒号:开关指令 一个冒号:需要参数  两个冒号:参数可选
# -o cr:d:q:w:   c是可选参数 其他都必须跟一个选项值
# -l 后面接长选项列表
# -n 指定哪个脚本处理这个参数
# 使用getopt和循环处理多参数和长参数的情况
TEMP=$(getopt -o cr:d:q:w: --long quality:arga,directory:,watermark:,prefix:,postfix:,help,resize: -n 'img.sh' -- "$@")

# -- 保证后面的字符串不直接被解析
#set会重新排列参数顺序 这些值在 getopt中重新排列过了
eval set -- "$TEMP"

#shift用于参数左移 shift n 前n位都会被销毁
while true ; do   
    case "$1" in
    
        -c) C_FLAG="1" ; shift ;;
        
        -r|--resize) R_FLAG="1";
            case "$2" in
                "") shift 2 ;;
                *)RESOLUTION=$2 ; shift 2 ;;
            esac ;;
            
        --help) H_FLAG="1"; shift ;;
        
        -d|--directory)
            case "$2" in 
                "") shift 2 ;;
                 *) DIR=$2 ; shift 2 ;;
            esac ;;
            
        -q|--quality) Q_FLAG="1";
            case "$2" in
                "") shift 2 ;;
                 *) quality=$2; shift 2 ;;  #todo if the arg is integer
            esac ;;
            
        -w|--watermark)W_FLAG="1"; watermark=$2; shift 2 ;;
        
        --prefix) PREFIX=$2; shift 2;;
        
        --postfix) POSTFIX=$2; shift 2 ;;
                
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done


main
