<?php 
// 打印当前目录及其子目录文件
function my_scandir($src)
{
	return array_diff(scandir($src), array('.', '..'));
}

function my_scandir2($src)
{
	static $result = array();
	$dir = opendir($src);
	while (false !== ($file = readdir($dir))) {
		if ($file != '.' && $file != '..') {
			$full = $src . '/' . $file;
			if (is_dir($full)) {
			    my_scandir2($full);
			}
			$result[] = $full;
		}
	}
	closedir($dir);
	return $result;
}

// 删除当前目录及其子目录文件
function my_rmdir($src)
{
	$dirs = array_diff(scandir($src), array('.', '..'));
	foreach ($dirs as $dir) {
		if (is_dir("$src/$dir")) {
			my_rmdir("$src/$dir");
		} else {
			unlink("$src/$dir");
		}
	}
	return rmdir($src);
}

function my_rmdir2($src)
{
	$dir = opendir($src);
    while(false !== ($file = readdir($dir))) {
        if ($file != '.' && $file != '..' ) {
            $full = $src . '/' . $file;
            if (is_dir($full)) {
            	rrmdir($full);
            } else {
                unlink($full);
            }
        }
    }
    closedir($dir);
    rmdir($src);
}

// 使用五种以上方式获取一个文件的扩展名
function getExt1($file_name) 
{
    return substr(strrchr($file_name, '.'), 1);
}

function getExt2($file_name) 
{
    return substr($file_name, strrpos($file_name, '.') + 1);
}

function getExt3($file_name) 
{
    return array_pop(explode('.', $file_name));
}

function getExt4($file_name) 
{
    return pathinfo($file_name, PATHINFO_EXTENSION);
}

function getExt5($file_name) 
{
    return strrev(substr(strrev($file_name), 0, strpos(strrev($file_name), '.')));
}

// 冒泡排序
function bubbleSort($arr)
{  
	$len = count($arr);
	// 该层循环控制 需要冒泡的轮数
	for ($i = 1; $i < $len; $i++) { 
		// 该层循环用来控制每轮 冒出一个数 需要比较的次数
		for ($j = 0;$j < $len - $i; $j++) {
			if ($arr[$j] > $arr[$j+1]) {
				$tmp = $arr[$j+1];
				$arr[$j+1] = $arr[$j];
				$arr[$j] = $tmp;
			}
		}
	}
	return $arr;
}

// 选择排序
function selectSort($arr) 
{
	// 双重循环完成，外层控制轮数，内层控制比较次数
	$len = count($arr);
	for($i = 0; $i < $len - 1; $i++) {
       // 先假设最小的值的位置
       $p = $i;
       
        for($j = $i + 1; $j < $len; $j++) {
            // $arr[$p] 是当前已知的最小值
            if($arr[$p] > $arr[$j]) {
            // 比较，发现更小的,记录下最小值的位置；并且在下次比较时采用已知的最小值进行比较。
            	$p = $j;
            }
        }
        // 已经确定了当前的最小值的位置，保存到$p中。如果发现最小值的位置与当前假设的位置$i不同，则位置互换即可。
        if($p != $i) {
        	$tmp = $arr[$p];
            $arr[$p] = $arr[$i];
            $arr[$i] = $tmp;
        }
    }
	// 返回最终结果
	return $arr;
}

// 插入排序
function insertSort($arr) 
{
	$len = count($arr);
	for ($i = 1; $i < $len; $i++) {
		$tmp = $arr[$i];
		// 内层循环控制，比较并插入
		for ($j = $i - 1; $j >= 0; $j--) {
			if($tmp < $arr[$j]) {
				// 发现插入的元素要小，交换位置，将后边的元素与前面的元素互换
				$arr[$j+1] = $arr[$j];
				$arr[$j] = $tmp;
			} else {
			   // 如果碰到不需要移动的元素，由于是已经排序好是数组，则前面的就不需要再次比较了。
			   break;
			}
	    }
	}
	return $arr;
}

// 快速排序
function quickSort($arr) 
{
	// 先判断是否需要继续进行
	$length = count($arr);
	if ($length <= 1) {
		return $arr;
	}
	// 选择第一个元素作为基准
	$base_num = $arr[0];
	// 遍历除了标尺外的所有元素，按照大小关系放入两个数组内
	// 初始化两个数组
	$left_array = array();  // 小于基准的
	$right_array = array();  // 大于基准的
	for ($i = 1; $i < $length; $i++) {
		if ($base_num > $arr[$i]) {
			// 放入左边数组
		    $left_array[] = $arr[$i];
		} else {
			// 放入右边
			$right_array[] = $arr[$i];
		}
	}
	// 再分别对左边和右边的数组进行相同的排序处理方式递归调用这个函数
	$left_array = quickSort($left_array);
	$right_array = quickSort($right_array);

	// 合并
	return array_merge($left_array, array($base_num), $right_array);
}