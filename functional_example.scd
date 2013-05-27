a = [3,4,5,13,14,138,139,140,141];

//I do this:

(
"The array %".format(a).postln;
b = [] ++ a.first;
d = b.copy;
a.doAdjacentPairs{arg v1, v2;
        if (v2-v1 > 1) {
                b = b.add(v2);
                d = d.add(v2)
        } {
                d.pop();
                d.add(v2)
        }
};
"Gives the following clumps: %".format([b, d].flop).postln; "";
)

a.reshapeLike(a.differentiate.delimit{|x| x>1}.drop(1).collect{|x| x++0}).collect{|x| [x[0], x[x.size-1]]}
a = [2,4,5,13,14,138,139,140,141];      //first value isn't adjacent
a.reshapeLike(a.differentiate.delimit{|x| x>1}.drop(1).collect{|x| x++0}).collect{|x| [x[0], x[x.size-1]]}

a = [3,4,5,13,14,138,139,140,141];
a.clumps((a-a[0]).differentiate.delimit{|x| x>1}.collect{|x| x.count{|x| x==1}+1}).collect{|x| [x[0], x[x.size-1]]}
a = [2,4,5,13,14,138,139,140,141];      //first value isn't adjacent
a.clumps((a-a[0]).differentiate.delimit{|x| x>1}.collect{|x| x.count{|x| x==1}+1}).collect{|x| [x[0], x[x.size-1]]}

a = [3,4,5,13,14,138,139,140,141];
a.separate { |x, y| absdif(x, y) > 1 }