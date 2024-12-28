package jvm;

public class code {

    private static int fibonacci(int n) {
        if (n <= 1) {
            return n;
        }
        int a = 0, b = 1, sum = 0;
        for (int i = 2; i <= n; i++) {
            sum = a + b;
            a = b;
            b = sum;
        }
        return b;
    }

    public static void main(String[] args) {
        var u = Integer.parseInt(args[0]);
        var runs = Integer.parseInt(args[1]);
        var r = 0;
        for (var i = 0; i < runs; i++) {
            r = 0;
            for (var j = 1; j < u; j++) {
                r += fibonacci(j);
            }
        }
        System.out.println(r);
    }
}
