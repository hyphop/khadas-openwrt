#!/bin/sh

## hyphop ##

#= smart svg -> bmp rgba gz converter

#inkscape=$(which inkscape 2>/dev/null)

ffmpeg=$(which ffmpeg 2>/dev/null)

[ "$IMG" ] || IMG="$1"
[ "$IMG" ] || IMG="$(dirname $0)/splash.svg"

FMT=bgra

OUT=${IMG%.*}.$FMT.bmp.gz
PNG=${IMG%.*}.png

echo "[i] convert $IMG -> $OUT"

[ "$ffmpeg" ] || {
    echo "[i] ffmpeg not found plz install it">&2
    exit 1
}

[ "$inkscape" ] && {

    $inkscape "$IMG" -e ${IMG%.*}.png || {
	exit 1
    }

    ffmpeg -y -hide_banner -i ${IMG%.*}.png -pix_fmt $FMT ${IMG%.*}.bmp || exit 1
    return 
}

#ffmpeg -y -hide_banner -i ${IMG%.*}.svg -pix_fmt rgb565 ${IMG%.*}.bmp || exit 1
#gzip -c ${IMG%.*}.bmp > ${IMG%.*}.bmp.gz

## simple one string way

#$ffmpeg -y -hide_banner -i $IMG $PNG
O=${IMG%.*}.$FMT.bmp
$ffmpeg -y -hide_banner -i $IMG -pix_fmt $FMT -vcodec bmp -f image2 $O
gzip -c9 $O > $OUT


