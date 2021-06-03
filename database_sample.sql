CREATE TABLE `badges` (
  `id` int(11) NOT NULL,
  `number` text NOT NULL,
  `name` text NOT NULL,
  `company` text NOT NULL,
  `expire` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table `badges`

INSERT INTO `badges` (`id`, `number`, `name`, `company`, `expire`, `created_at`) VALUES
(1, '001488133', 'PETER', 'Peter Company Ltd', '2021-06-01', '2021-06-01 12:00:00'),
(2, '001492646', 'Martin', 'Martin Company Ltd', '2022-06-02', '2021-06-01 12:00:00'),
(3, '001491296', 'John', 'John Co. Ltd', '2022-06-02', '2021-06-02 12:00:00');
