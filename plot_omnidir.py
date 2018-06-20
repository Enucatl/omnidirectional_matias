import click
import numpy as np
import scipy.io as sio
import csv


@click.command()
@click.argument("input_file", type=click.Path(exists=True))
@click.argument("output_file", type=click.File("w"))
def main(input_file, output_file):
    array = sio.loadmat(input_file)
    darkfield = array["Bf"][:125:2, 45:140:2]
    writer = csv.writer(output_file)
    writer.writerow(["x", "y", "u", "v", "d", "a"])
    n = darkfield.shape[2]
    for y, line in enumerate(darkfield):
        for x, d in enumerate(line):
            length = -np.log(np.max(d))
            transformed = np.fft.fft(d)
            a = 2 * np.abs(transformed[1]) / np.abs(transformed[0])
            i = np.argmax(d)
            u = a * np.cos(i / n * np.pi)
            v = a * np.sin(i / n * np.pi)
            writer.writerow([x, y, u, v, length, a])
    print(darkfield.shape)


if __name__ == "__main__":
    main()
